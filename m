Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280608AbRKNOf0>; Wed, 14 Nov 2001 09:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280612AbRKNOfQ>; Wed, 14 Nov 2001 09:35:16 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:64145 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280608AbRKNOfJ>; Wed, 14 Nov 2001 09:35:09 -0500
Date: Wed, 14 Nov 2001 14:35:07 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: <linux-kernel@vger.kernel.org>
Subject: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Message-ID: <Pine.GSO.4.33.0111141421230.14971-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks - I'm having real problems getting our new dual CPU server
going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
an Adaptec SCSI controller and 512Mb DDR SDRAM. I'm not a Linux newbie
at all, but I've never tried running it on such exotic hardware before,
and it doesn't seem happy....

I installed Red Hat 7.2 and the machine boots fine, using SMP or UP
kernels (Red Hat 2.4.9-7), but totally HANGS at the login prompt. Can't
type, can't reboot, can't do anything. Single user mode _does_ let me
in, however, and this is the only progress so far.

I then tried building a custom 2.4.15-pre4 (on another machine), which
compiled perfectly happily, and I installed this on the server. It
panic'd due to failure to mount the root filesystem. I made an
initrd.img, and it then got further (detecting and initialising the SCSI
controller), but still panic'd with the same message.

I then threw down the gauntlet and installed the rawhide Athlon
SMP kernel (based on 2.4.13) which also booted fine but HUNG at the
login prompt, as above. Finally, I tried the i686 version, which spewed
out tons of error messages regarding "invalid symbols" in the ext3
module.

Either way, I'm stumped. Am I up against an Athlon / chipset problem
here, or is something else wrong? What do I need to do to get my
custom-built 2.4.15-pre4 rolling - why can't it mount the root
partition?

Cheers
Alastair

_____________________________________________
Alastair Stevens
MRC Biostatistics Unit
Cambridge UK
---------------------------------------------
phone - 01223 330383
email - alastair.stevens@mrc-bsu.cam.ac.uk
web - www.mrc-bsu.cam.ac.uk

