Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129491AbRCFVJr>; Tue, 6 Mar 2001 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRCFVJ1>; Tue, 6 Mar 2001 16:09:27 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:38080 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129491AbRCFVJV>; Tue, 6 Mar 2001 16:09:21 -0500
Message-ID: <3AA550C8.59FC1B4A@coplanar.net>
Date: Tue, 06 Mar 2001 16:04:08 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Jeremy <prrthd25@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: VFS: Cannot open root device
In-Reply-To: <20010303011000.1832.qmail@web4203.mail.yahoo.com> <3AA04B88.9B4E5AF8@coplanar.net> <20010306142232.C28368@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:

> [Jeremy Jackson]
> > try command 'man mkinitrd' under redhat for hints about initial
> > ramdisk.
>
> I have been puzzled about this for quite some time.  Why exactly does
> everyone always recommend using 'mkinitrd' on Red Hat systems?  It
> seems to me that if you are compiling a kernel for a specific server
> anyway, it is a much more reliable proposition to just compile in
> whatever drivers you need to boot.
>
> initrd's are inherently clumsy and fragile, to my way of thinking.
> I've always thought they should only be used to support diverse or
> unknown hardware, or odd cases like crypto loopback root.  Are there
> other advantages to 'mkinitrd' in the case of a custom kernel for a
> single machine?
>

no the reason redhat uses it is to allow a generic kernel for everyone.
having *ALL* drivers in kernel would make it huge, and some drivers
conflict with each other (not many) so they couldn't all be in there.

If you have made a custom kernel (that is configured properly) you don't
need to bother.  The question is if you configured it properly :)

I would suggest taking a config from redhat (it puts them in
/usr/src/linux/configs)
and just tweaking that. (sorry if i already said that once)

other pitfalls include not having the right root= entry (or missing one) in
lilo.conf.

>
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

