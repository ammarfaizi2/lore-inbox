Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWGJPzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWGJPzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWGJPzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:55:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:9229 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422670AbWGJPyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:54:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJXFj4+9CgoB+CczZ6X1k873Ilr2sqMbRqFH9Hy0lKKU/BgMgjxZdWlBxQ13elOom/YE/vpVWD8wNcq10A8BK6CXWU33UrITedJb2HW6tsWHyc3RRfPOsa9Lkawm6AhuSVVjYzwnGQ+NN+4caM5pw6SaKquNiFG4JvYXU4Hq2jM=
Message-ID: <9e4733910607100854x250e9d3aga027ef5e156ec34e@mail.gmail.com>
Date: Mon, 10 Jul 2006 11:54:47 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       "Greg KH" <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <44B273B9.8050308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
	 <1152537049.27368.119.camel@localhost.localdomain>
	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
	 <1152539034.27368.124.camel@localhost.localdomain>
	 <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
	 <44B26752.9000507@gmail.com>
	 <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com>
	 <1152544746.27368.134.camel@localhost.localdomain>
	 <44B273B9.8050308@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Alan Cox wrote:
> > Ar Llu, 2006-07-10 am 10:57 -0400, ysgrifennodd Jon Smirl:
> >>> A few apps do rely on /proc/tty/drivers for the major-minor
> >>> to device name mapping. /dev/vc/0 does not exist (unless
> >>> created manually) without devfs.
> >> This is why I questioned if /proc/tty was really in use, it contains
> >> an entry that is obviously wrong for my system.
> >
> > Which tools already know about.
>
> True.  I see this code snippet many times:

BSD has /dev/vc/0 right? I suspect that code is there to support BSD
and make the app portable.

As far as I know the only time Linux has ever had /dev/vc/0 was during
the brief excursion into devfs land. At that time /proc/tty/drivers
was modified to support devfs.  But now devfs has been removed and the
device has reverted back to tty0. But /proc/tty/drivers wasn't
adjusted for devfs removal.

> fd = open("/dev/vc/0", FLAGS);
> if (fd == -1)
>         fd = open("/dev/tty0", FLAGS);
>
> > What is so hard to understand about the
> > idea that pointless random changes break stuff and don't fix things.
>
> But since we're killing devfs, changing /dev/vc/0 to /dev/tty0 will be one
> of the nails in devfs' coffin :-)
>
> Tony
>


-- 
Jon Smirl
jonsmirl@gmail.com
