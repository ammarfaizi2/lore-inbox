Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030646AbWLAJJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646AbWLAJJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030648AbWLAJJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:09:20 -0500
Received: from palakse.guam.net ([202.128.0.38]:7629 "EHLO palakse.guam.net")
	by vger.kernel.org with ESMTP id S1030646AbWLAJJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:09:18 -0500
From: "Michael D. Setzer II" <mikes@kuentos.guam.net>
To: linux-kernel@vger.kernel.org
Date: Fri, 01 Dec 2006 19:09:16 +1000
MIME-Version: 1.0
Subject: Change Required in building ISO with 2.6.19
Message-ID: <45707DDC.7760.62D5221@mikes.kuentos.guam.net>
X-PM-Encryptor: QDPGP, 4
X-mailer: Pegasus Mail for Windows (4.41)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've been working on the g4l disk imaging project, and have been trying to 
keep kernels for the cd up-to-date to work for those users with the latest 
hardware. I was recommended to try the 2.6.19-git kernel since the kernels 
since 2.6.15.6 that I've build from kernel.org do not work with the sata_via. 
All the kernels from 2.6.18.3 and below have worked with the makecd script 
that was created by the previous project manager. The 2.6.19 git and 
released kernel required me to modify the script to use a 4096 byte block 
size instead of the default 1024 bytes. Problem is, that the earlier computers 
don't mount with the 4K, but the 2.6.19 don't work with the 1K size. It goes 
all the way thru, but they fail with trying to mount the /. 

Only difference in the scripts 
Using 4K for 2.6.19 kernels 
< mke2fs -m 0 -b 4096 -N 4000 /dev/loop0 
- --- 
Using 1K default for all earlier kernels. 
> mke2fs -m 0 -N 4000 /dev/loop0 

I have no knowledge on the script, so it might be something in the script that 
makes the difference, but would like to have a way to allow both the older 
and newer kernels to reside on one image. It now requires to different CDs. 

Full Original script with default 1k 
ftp://amd64gcc.dyndns.org/makecd1k 

Modified script with 4k option 
ftp://amd64gcc.dyndns.org/makecd4k 

+----------------------------------------------------------+
  Michael D. Setzer II -  Computer Science Instructor      
  Guam Community College  Computer Center                  
  mailto:mikes@kuentos.guam.net                            
  mailto:msetzerii@gmail.com
  http://www.guam.net/home/mikes
  Guam - Where America's Day Begins                        
+----------------------------------------------------------+

http://setiathome.berkeley.edu
Number of Seti Units Returned:  19,471
Processing time:  32 years, 290 days, 12 hours, 58 minutes
(Total Hours: 287,489)

BOINC TOTAL CREDITS SETI@HOME/EINSTEIN@HOME
Total Credits 2294755.789617 
Total Credits 305549.598810 


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8 -- QDPGP 2.61c
Comment: http://community.wow.net/grt/qdpgp.html

iQA/AwUBRW9knSzGQcr/2AKZEQKIIACg/sT/MjU3WRYY0X/BxlzvZnea4k0AoMuI
WY32l9CMXSxdxi0w56U/Gj5+
=xp+T
-----END PGP SIGNATURE-----
