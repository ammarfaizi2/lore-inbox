Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136354AbRD2UqD>; Sun, 29 Apr 2001 16:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136357AbRD2Upx>; Sun, 29 Apr 2001 16:45:53 -0400
Received: from 13dyn119.delft.casema.net ([212.64.76.119]:518 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S136354AbRD2Upo>; Sun, 29 Apr 2001 16:45:44 -0400
Message-Id: <200104292045.WAA25392@cave.bitwizard.nl>
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <3AEC7A9F.17EBEE57@transmeta.com> from "H. Peter Anvin" at "Apr
 29, 2001 01:33:35 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Sun, 29 Apr 2001 22:45:41 +0200 (MEST)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Gregory Maxwell <greg@linuxpower.cx>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Rogier Wolff wrote:

> > The image of the disk (including partition table) is at:
> > 
> >         ftp://ftp.bitwizard.nl/misc_junk/formatted.img.gz
> > 
> > It's 63kb and uncompresses to the 64Mb (almost) that it's sold as.
> > 
> 
> And on at least this kernel (2.4.0) there is nothing funny about it:
> 
> : tazenda 13 ; ls -l /mnt
> total 0
> -r-xr-xr-x    1 root     root            0 May 23  2000 memstick.ind*
> : tazenda 14 ; 
> 
> Mounting msdos, vfat or umsdos, no change.

OK. I rebooted the laptop: 

  Linux version 2.2.13 (root@Mandelbrot.suse.de) (gcc version
  egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Nov 8
  15:37:25 CET 1999

which seems to have cleared it. Somehow that directory was still
cached somewhere (not in the buffer cache) from when there were images
on the memory stick.

So, I'm suspecting a dcache bug, that allows something to stay over
after swapping a removable media device.... And all this is irrelevant
as this was on a very old kernel. Sorry to have been wasting your
time.

			Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
