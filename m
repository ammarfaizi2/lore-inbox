Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbRDPCAp>; Sun, 15 Apr 2001 22:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbRDPCAg>; Sun, 15 Apr 2001 22:00:36 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:16657 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S132834AbRDPCA0>;
	Sun, 15 Apr 2001 22:00:26 -0400
Date: Mon, 16 Apr 2001 03:54:56 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org
Subject: devfs weirdnesses in 2.4.3 (-ac5)
Message-ID: <20010416035456.A29398@kallisto.sind-doof.de>
Mail-Followup-To: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently noticed some weird behaviour in devfs.

- some symlinks not showing up in directory listings, although they
  are surely existing. I noticed this with symlinks created by devfsd
  for IDE devices (/dev/hda{9,10,11} showing in normal ls, other hda
  entries are hidden). If I explicitly give the name of one of the
  hidden symlinks (for example "ls -l /dev/hda"), it shows the
  symlink, and I can see that the symlink is absolutely correct (as
  far as ls output goes...). Sadly I'm not able to reproduce this
  behaviour now, but read on.
- same thing with ippp*. Some ippp symlinks are now hidden. If I do a
  "rm ippp*" in /dev, the visible symlinks are removed, and
  the hidden entries become visible. With a second "rm ippp*", the
  originally hidden symlinks are also removed.

The kernel version used is 2.4.3-ac5, but as the ac patches only
change one line in devfs code, related to devfsd notification, I think
the problem should exist in non-ac kernel also.

Andreas
-- 
Our missions are peaceful -- not for conquest.  When we do battle, it
is only because we have no choice.
		-- Kirk, "The Squire of Gothos", stardate 2124.5

