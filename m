Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSCCNfL>; Sun, 3 Mar 2002 08:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293503AbSCCNfC>; Sun, 3 Mar 2002 08:35:02 -0500
Received: from white-ippp0.koehntopp.de ([195.244.233.49]:30469 "EHLO
	white.koehntopp.de") by vger.kernel.org with ESMTP
	id <S285424AbSCCNev>; Sun, 3 Mar 2002 08:34:51 -0500
Date: Sun, 3 Mar 2002 14:34:56 +0100
From: Kristian Koehntopp <kris@koehntopp.de>
To: linux-kernel@vger.kernel.org
Subject: DRL for RAID 1?
Message-ID: <20020303143456.A8587@white.koehntopp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anybody implemented DRL for RAID 1?

After a crash, my RAID 1 tries to resync the entire mirror:

kris@valiant:~> cat /proc/mdstat
Personalities : [raid1]
read_ahead 1024 sectors
md0 : active raid1 sdc8[1] sda8[0]
      12241408 blocks [2/2] [UU]
      [==>..................]  resync = 11.0% (1358400/12241408)
finish=124.3min speed=1457K/sec
unused devices: <none>

With a region bitmap and dirty region logging, the recovery time
would be much lower, since the RAID subsystem does not have to
resync all of the disk, but only those regions marked as dirty
during a crash.

Kristian

