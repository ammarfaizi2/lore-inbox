Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBPBnu>; Thu, 15 Feb 2001 20:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRBPBnl>; Thu, 15 Feb 2001 20:43:41 -0500
Received: from mail.valinux.com ([198.186.202.175]:54289 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129104AbRBPBnW>;
	Thu, 15 Feb 2001 20:43:22 -0500
Message-ID: <3A8C85B9.610D0C06@valinux.com>
Date: Thu, 15 Feb 2001 17:43:21 -0800
From: Samuel Flory <sflory@valinux.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre11-va1.7smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "tytso@valinux.com" <tytso@valinux.com>
Subject: mke2fs and kernel VM issues
In-Reply-To: <Pine.LNX.4.30.0102151634380.16783-100000@ns-01.hislinuxbox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  What is believed to be the current status of the typical mke2fs
crashes/hangs due to vm issues?  I can reliably reproduce the issue on a
heavily modifed VA kernel based on 2.2.18.  Is there a kernel which is
believed to be a known good kernel?  (both 2.2.x and 2.4.x)

Failure pattern:

System:
mylex raid 5 array 8 x 9G drives  (not really all that big)
>=512M of RAM (1G of RAM works)
no swap  (Not sure if this makes a difference.)

The system is attempting to create a single partition containing the
most of the entire RAID array.

errors:
buffy: Installing with LIVE AMMO
Creating partitions...
Initializing filesystems...
Out of Memory: Killed process 106 (portmap), saved process 2165
(mke2fs).<3>Out
of Memory: Killed process 2123 (buffy), saved process 2165
(mke2fs).willow: LOAD
 FAILED
<3>Out of Memory: Killed process 195 (sisyphus_upload), saved process
2165 (mke2
fs).<3>Out of Memory: Killed process 2165 (mke2fs).

(Note that most of the above proccesses were dialog interfaces waiting
for user input or perl scripts waiting for mke2fs or buffy to exit.)


PS- Conversations with various VA empolyees indicates that others within
VA, and at least one vendor are seeing hangs while creating really large
filesystems on RAID arrays. (mostly 1/4 TB or larger)  These issues
appear to come and go, and are endemic to the 2.2.x kernel line.  Both
lnz and tytso seem to believe the issues to be vm entirely related.

-- 
Solving people's computer problems always
requires more hardware be given to you.
(The Second Rule of Hardware Acquisition)
Samuel J. Flory  <sam@valinux.com>
