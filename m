Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUCXLgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 06:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbUCXLgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 06:36:14 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:17932 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263295AbUCXLgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 06:36:11 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Date: Wed, 24 Mar 2004 12:35:51 +0100
User-Agent: KMail/1.6.1
Cc: Martin Zwickel <martin.zwickel@technotrend.de>,
       Andrew Morton <akpm@osdl.org>, support@nvidia.com
References: <20040323232511.1346842a.akpm@osdl.org> <20040324110014.4cdb7597@phoebee>
In-Reply-To: <20040324110014.4cdb7597@phoebee>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XKXYAykqmr8sozY"
Message-Id: <200403241235.51786@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XKXYAykqmr8sozY
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 24 March 2004 11:00, Martin Zwickel wrote:

Hi Martin,

> I'm unable to start my X server with this patch.
> I have the nvidia 5336 module loaded and if I start the X server, the
> machine completely freezes. With 2.6.5-rc2 everything works ok...
> If anyone wants my config, ask me.

apply this patch ontop of 2.6.5-rc2-mm2 tree to get nvidia working again.

nvidia inc: *hint hint* ;)

ciao, Marc

--Boundary-00=_XKXYAykqmr8sozY
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="4k-reenable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="4k-reenable.patch"

diff -Naurp linux-2.6.5-rc1-mm1/arch/i386/Kconfig linux-2.6.5-rc1-mm1-removed/arch/i386/Kconfig
--- linux-2.6.5-rc1-mm1/arch/i386/Kconfig	2004-03-16 21:28:03.000000000 +0100
+++ linux-2.6.5-rc1-mm1-removed/arch/i386/Kconfig	2004-03-16 21:32:08.000000000 +0100
@@ -1555,7 +1555,14 @@ config MAGIC_SYSRQ
 	default y
 
 config 4KSTACKS
-	def_bool y
+	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	default n
+	help
+	  If you say Y here the kernel will use a 4Kb stacksize for the
+	  kernel stack attached to each process/thread. This facilitates
+	  running more threads on a system and also reduces the pressure
+	  on the VM subsystem for higher order allocations. This option
+	  will also use IRQ stacks to compensate for the reduced stackspace.
 
 config X86_FIND_SMP_CONFIG
 	bool

--Boundary-00=_XKXYAykqmr8sozY--
