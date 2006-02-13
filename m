Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWBMMMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWBMMMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBMMMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:12:48 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:48893 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932103AbWBMMMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:12:47 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 13:11:27 +0100
To: nix@esperi.org.uk, davidsen@tmr.com
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0776F.nailKUS94FU3M@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
In-Reply-To: <43ED005F.5060804@tmr.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:


> I notice that the first thing people suggest is to make things like 
> udev, hal and sysfs required instead of optional to do something as 
> simple as burn a CD. As I mentioned before, if the kernel provided a 
> list of devices then applications wouldn't break every time a new kernel 
> came out which needs a new this, and new that, and a few new other 
> support things.

This would make sense in case that a useful definition with a granted lifetime 
of at least 10 years would be implemented.


> The kernel could provide a list of devices by category. It doesn't have 

What if the kernel does not understand the cetegory?

Common oddities:

-	Mac OS X tries to distinct between CD/DVD writers and CD/DVD-ROM
	although there is only one device class.

-	Older CD-writers identified as WORM although a CD-R is not a WORM.

> to name them, run scripts, give descriptions, or paint them blue. Just a 
> list of all block devices, tapes, by major/minor and category (ie. 
> block, optical, floppy) would give the application layer a chance to do 
> it's own interpretation. HAL is great, but because it's not part of the 
> kernel it's also going to suffer from "tracking error" for some changes. 
> I find it easier to teach someone to use -scanbus than to explain how to 
> make rules for udev.

As this categorisation does not work, we need a way to find all devices 
that talk SCSI and let the application decicde what device is supported.


> Worth repeating: I find it easier to teach someone to use -scanbus than 
> to explain how to make rules for udev. HAL is the right answer, but *in* 
> the kernel, where it will track changes. Since -scanbus tells you a 
> device is a CDrecorder, or something else, *any user* is likely to be 
> able to tell it from DCD, CD-ROM, etc. Nice like of text for most devices...

So you seem to agree with me.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
