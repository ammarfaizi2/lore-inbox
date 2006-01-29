Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWA2LIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWA2LIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 06:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWA2LIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 06:08:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:57784 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750920AbWA2LID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 06:08:03 -0500
Date: Sun, 29 Jan 2006 12:07:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: linux-xfs@oss.sgi.com
Subject: reinitializing quota on xfs
Message-ID: <Pine.LNX.4.61.0601291204380.18492@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


for some strange reason, `quota -v` showed an impossible number in the 
inodes (files) field, something that resembled 2^64 - n, n={1..100}. I do 
not know how it happened, but I wanted to reinitialize the quota. Though, 
how does one do that with XFS? (Since it's different from the vfsv0 quota 
architecture.)

By chance, I could make xfs reinit it using:
  quotaoff /D
  touch /D/something
  umount /D
  mount /D   # impliclty mounts with usrquota,grpquota (options in fstab)

but it would have been nicer to have a mount option.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
