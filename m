Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279547AbRKSROy>; Mon, 19 Nov 2001 12:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280254AbRKSROf>; Mon, 19 Nov 2001 12:14:35 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:6903 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280251AbRKSROZ>;
	Mon, 19 Nov 2001 12:14:25 -0500
Date: Mon, 19 Nov 2001 10:13:40 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: DD-ing from device to device.
Message-ID: <20011119101340.I1308@lynx.no>
Mail-Followup-To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200111181326.OAA28770@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111181326.OAA28770@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Sun, Nov 18, 2001 at 02:26:19PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 18, 2001  14:26 +0100, Rogier Wolff wrote:
> I should NOT get a "file too large" error when copying from a device
> to a device, right?
> 
> I should NOT get a "file too large" if the files are openeed using
> the "O_LARGEFILE" option, right?
> 
> read(4, ""..., 1048576) = 1048576
> write(5, ""..., 1048576) = 1048576
> read(4, ""..., 1048576) = 1048576
> write(5, ""..., 1048576) = 1048575
> write(5, ".", 1)                     = -1 EFBIG (File too large)
> 
> 
> 
> This is on 2.2.14. I Could swear we made a working copy of a disk 30
> minutes earlier....

Hmm, you mean 2.4.14 I take it?  There is another report saying 2.4.14
also "Creating partitions under 2.4.14", and I have read several more
recently but am unsure of the exact kernel version.  What fs are you
using, just in case it matters?

I know for sure that 2.4.13+ext3 is working mostly OK, as I have been
playing with multi-TB file sizes (sparse of course) although there is
a minor bug in the case where you hit the fs size maximum.  I'm glad
my patch isn't in yet, or I would be getting flak over this I'm sure.

The only problem is that I can't see anything in the 2.4.14 patch which
would cause this problem.  All the previous reports had to do with
ulimit, caused by su'ing to root instead of logging into root, but I'm
not sure exactly where the problem lies.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

