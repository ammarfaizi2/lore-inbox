Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSFHX0P>; Sat, 8 Jun 2002 19:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317479AbSFHX0O>; Sat, 8 Jun 2002 19:26:14 -0400
Received: from u195-95-84-180.dialup.planetinternet.be ([195.95.84.180]:24070
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S317478AbSFHX0O>; Sat, 8 Jun 2002 19:26:14 -0400
Message-Id: <200206082325.g58NP8gf029372@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: lilo causes an oops after unloading IDE CD modules
Date: Sun, 09 Jun 2002 01:25:08 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an (aging) P5 SMP box which is all-scsi except for an
el-cheapo IDE CD drive. Because I almost never use the CD, I
have the drivers compiled as modules and autoclean them.

Ever since switching from 2.5.7 to (I think) 2.5.9, I've had 
problems with `make bzlilo' causing the system to hang (which 
*is* nasty). 

Today I finally figured out a pattern: immediately after 
booting, I can run lilo as often as I want, no problem. But 
as soon as the ide-cd, cdrom, and ide-mod modules have been 
unloaded, running lilo will result in an oops (not always the 
same one). If I prevent the unloading by mounting a CD, lilo 
runs fine no matter how hard and for how long I beat the 
machine.

My current kernel is 2.5.20 with modutils-2.4.12. Anyone 
interested in hunting this thing down? I lack both time and 
knowledge to do it myself, but am wiling to test patches.

MCE
-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a36 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

