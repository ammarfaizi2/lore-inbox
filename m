Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVCYMuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVCYMuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 07:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVCYMuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 07:50:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:56018 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261296AbVCYMuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 07:50:12 -0500
Date: Fri, 25 Mar 2005 13:50:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: relayfs doc bug
Message-ID: <Pine.LNX.4.61.0503251347240.20353@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello relayfs devs,


the documentation to the [old] relayfs (2.6.10-patch from opersys):

absolute path to the channel file on relayfs.  If, for example, the
caller sets channel_path to "/xlog/9", a "xlog/9" entry will appear
within relayfs automatically and the "xlog" directory will be created

This is wrong. If I use /xlog/9, I get a dentry with zero length, e.g.:

/dev/relay # ls -l
drwxr-xr-x   2 root root      0 Mar 25 09:52
drwxr-xr-x   3 root root      0 Mar 25 12:05 .
drwxr-xr-x  39 root root 183712 Mar 25 13:42 ..
-rw-------   1 root root      0 Mar 25 09:52 a_channel

(the channel would be /dev/relay//xlog/9, but that's impossible, since multiple
/ are merged). Works well when I use "xlog/9".


Jan Engelhardt
-- 
