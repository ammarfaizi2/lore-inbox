Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVAXAiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVAXAiX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVAXAiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:38:23 -0500
Received: from lakermmtao01.cox.net ([68.230.240.38]:14831 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261394AbVAXAiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:38:10 -0500
In-Reply-To: <200501202240.02951.Norbert@edusupport.nl>
References: <1106250687.3413.6.camel@localhost.localdomain> <200501202240.02951.Norbert@edusupport.nl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3851EEAE-6DA0-11D9-A93E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: LVM2
Date: Sun, 23 Jan 2005 19:38:09 -0500
To: Norbert van Nobelen <Norbert@edusupport.nl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 20, 2005, at 16:40, Norbert van Nobelen wrote:
> RAID5 in software works pretty good (survived a failed disk, and 
> recovered
> another failing raid in 1 month). Hardware is better since you don't 
> have a
> boot partition left which is usually just present on one disk (you can 
> mirror
> that yourself ofcourse).

Err, you _can_ boot completely from a software RAID, it just takes a 
bit more
work.  I have an old PowerMac G4 400MHz with a Promise 20268 controller 
and 3
80GB drives booting from a software RAID.  You just set up a 250-500MB 
boot
partition mirrored with RAID 1 across all drives, then set up a RAID 5 
swap
partition and a RAID 5 LVM partition on each drive.  Once LVM is 
configured
with each remaining filesystem, install your distro (The new 
Debian-installer
does very well) and set up Yaboot/GRUB/whatever to install a boot 
sector on
each drive.  Then set up a RAID+LVM initrd (Debian does this mostly
automatically too), and reboot. This computer boots a custom 2.6.8.1 
kernel,
has 896MB RAM, and a 400MHz CPU, but it reads 41.5MiByte/sec from its 
RAID 5
partition with a 1MiByte blocksize, and has 16.8MiByte/sec over LVM over
RAID 5 with the same blocksize.  I've been following the discussions on 
2.6
instability and "New development model" problems, but AFAICT, 2.6 has 
been
rock stable on this box, which acts as an IPv4/IPv6 
router/firewall/server.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


