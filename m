Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131560AbRCXD4Y>; Fri, 23 Mar 2001 22:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRCXD4O>; Fri, 23 Mar 2001 22:56:14 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:28559 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S131560AbRCXD4G>;
	Fri, 23 Mar 2001 22:56:06 -0500
Date: Sat, 24 Mar 2001 14:55:07 +1100 (EST)
Message-Id: <200103240355.f2O3t7u05500@pcug.org.au>
From: sfr@canb.auug.org.au
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        twoller@crystal.cirrus.com
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> > On the ThinkPad 600E (at least), we get a Power Status Change APM event.
> 
> Any reason we couldn't recalibrate the bogomips on a power status change,
> at least for laptops we know appear to need it (I can make the DMI code look
> for matches there..)

No reason at all ... I'll have a look.  I don't have my ThinkPad any more
(as of yesterday) so someone will have to supply the DMI info to match.
I will add another field to the apm_info structure that the DMI code can set
and then just test for it in the APM event loop.

Note, however, that there will still be a latency of up to a second
before we discover this situation as that is how often we poll the
BIOS for events.

Cheers,
Stephen Rothwell
sfr@canb.auug.org.au
