Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUCHVxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUCHVxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:53:10 -0500
Received: from rootshell.ru ([217.76.32.62]:39912 "EHLO
	helminth.linuxhacker.ru") by vger.kernel.org with ESMTP
	id S261273AbUCHVvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:51:41 -0500
Date: Tue, 9 Mar 2004 00:51:39 +0300
From: mator@helminth.linuxhacker.ru
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 VIA sound driver Config.in patch
Message-ID: <20040308215139.GA15630@helminth.linuxhacker.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.
This patch enables stats/info for VIA onboard sound codec driver 
accessible via /proc fs.
CONFIG_SOUND_VIA82CXXX_PROCFS declared in source code, but missed in 
Config.in.
Apply if needed. Same missing in 2.6.x kernel tree.

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-sound-codec.diff"

--- linux/drivers/sound/Config.in-orig	2004-01-18 15:52:57.000000000 +0300
+++ linux/drivers/sound/Config.in	2004-01-18 15:58:15.000000000 +0300
@@ -129,6 +129,7 @@
 fi
 
 dep_tristate '  VIA 82C686 Audio Codec' CONFIG_SOUND_VIA82CXXX $CONFIG_PCI
+dep_mbool    '  VIA codec /proc entry' CONFIG_SOUND_VIA82CXXX_PROCFS $CONFIG_SOUND_VIA82CXXX
 dep_mbool    '  VIA 82C686 MIDI' CONFIG_MIDI_VIA82CXXX $CONFIG_SOUND_VIA82CXXX
 
 dep_tristate '  OSS sound modules' CONFIG_SOUND_OSS $CONFIG_SOUND

--LZvS9be/3tNcYl/X--
