Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUDAUWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbUDAUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:22:48 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:15113 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263147AbUDAUWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:22:45 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: disable-cap-mlock
Date: Thu, 1 Apr 2004 22:23:07 +0200
User-Agent: KMail/1.6.1
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com,
       Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <1080845238.25431.196.camel@moss-spartans.epoch.ncsc.mil> <20040401192612.GL791@holomorphy.com>
In-Reply-To: <20040401192612.GL791@holomorphy.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404012223.07871@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_roHbACHoxqIht9o"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_roHbACHoxqIht9o
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 01 April 2004 21:26, William Lee Irwin III wrote:

Hi Bill,

> Okay, done.
> Misc fix thrown in: the policies beyond enabled/disabled were wrongly
> set up in minmax' args, so this throws the real max in the table.

Great. Works :) ... Prolly the attached one ontop.


ciao, Marc



--Boundary-00=_roHbACHoxqIht9o
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="sysctl_capable-Kconfig-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysctl_capable-Kconfig-update.patch"

--- old/security/Kconfig	2004-04-01 20:31:11.000000000 +0200
+++ new/security/Kconfig	2004-04-01 22:19:14.000000000 +0200
@@ -109,6 +109,19 @@ config SECURITY_CAPABILITY_SYSCTL
 	  It's probably best to firewall the living daylights out
 	  of anything using this also.
 
+	  Anyway, the values are:
+
+	  - 0 = checks enabled (the default)
+	  - 1 = checks disabled
+	  - 2 = root only
+	  - 3 = no one, even root has no access to capabilities
+
+	  All the sysctl entries are mutable until the "lockdown"
+	  entry is set to a non-zero value. All capabilities are
+	  enabled by default.
+
+	  Say N unless you know what you are doing.
+
 source security/selinux/Kconfig
 
 endmenu

--Boundary-00=_roHbACHoxqIht9o--
