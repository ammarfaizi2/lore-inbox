Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289240AbSA3PIg>; Wed, 30 Jan 2002 10:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289230AbSA3PI0>; Wed, 30 Jan 2002 10:08:26 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:24592 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S289240AbSA3PII>;
	Wed, 30 Jan 2002 10:08:08 -0500
Message-ID: <3C580C64.4960C63@obviously.com>
Date: Wed, 30 Jan 2002 10:08:20 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux_udf@hpesjro.fc.hp.com,
        util-linux@math.uio.no
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <E16LMQj-0008Hv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Bryce wrote: 
> > Understood.   However, why can't that combination "just work"?  Changing
> > [mount] every time I switch between sticking in a CD-ROM and DVD-ROM is not cool.
> > Certainly that "other operating system" does not make me do that.
> 
> man fstab
> man ln

Here's the final resolution on this issue:

	fstab(5) now mentions "udf".

	mount(8) now has the key piece of information - "udf
	and iso9660 co-exist on many discs".

	mount -t auto now automounts udf.
	This required scanning the extended area as you can't
	tell from the first VSD.

Most people will never need to think about the issue again, dvd-rom's will
just mount.  Poof.

Thanks for the tips and pointers that helped identify the cause.

			-Bryce
