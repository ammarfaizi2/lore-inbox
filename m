Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbTH0DYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 23:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTH0DYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 23:24:44 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:11995
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S263046AbTH0DYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 23:24:43 -0400
Date: Wed, 27 Aug 2003 05:25:17 +0200
From: Voluspa <lista1@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: NFS regression since 2.6.0-test3 (in -test4 and 4-mm1)
Message-Id: <20030827052517.79d65038.lista1@comhem.se>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Transfer time doubled and kernel log is swelling...

Remote is exported rw,no_root_squash and runs a Slackware 7.1.0
(Universal NFS Server 2.2beta47) kernel 2.2.16. Mounted here with a
simple "-t nfs". Both remote and local is ext2.

_2.6.0-test3_

"cp -a" the remote /etc directory takes 2 minutes. /var/log/kernel says:

Aug 27 03:59:59 loke kernel: eth0: media is TP.
Aug 27 04:02:34 loke kernel: nfs warning: mount version older than
kernel

Duh! I'm using your util-linux-2.12pre.tar.gz so stop complaining.

_2.6.0-test4 and -mm1_

The transfer takes 4 minutes and log is filled with:

Aug 27 04:20:47 loke kernel: eth0: media is TP.
Aug 27 04:22:34 loke kernel: nfs warning: mount version older than
kernel
Aug 27 04:23:21 loke kernel: nfs: server oden.fish.net not
responding, still trying
Aug 27 04:23:41 loke kernel: nfs: server oden.fish.net OK
Aug 27 04:24:00 loke kernel: nfs: server oden.fish.net not responding,
still trying

[Lots of lines deleted]

Aug 27 04:27:00 loke kernel: nfs: server oden.fish.net OK
Aug 27 04:27:01 loke kernel: nfs: server oden.fish.net not responding,
still trying
Aug 27 04:27:01 loke kernel: nfs: server oden.fish.net OK

Last night the complete backup took 9 hours (transfer of 1.2 gig).
That's why I noticed the issue.

Mvh
Mats Johannesson
