Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTKCPo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 10:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTKCPo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 10:44:28 -0500
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:23424 "EHLO ds666")
	by vger.kernel.org with ESMTP id S262055AbTKCPoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 10:44:25 -0500
Message-ID: <3FA677D7.1000100@portrix.net>
Date: Mon, 03 Nov 2003 16:44:23 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
References: <3FA62DD4.1020202@portrix.net> <20031103110129.GF1772@x30.random> <3FA63A57.8070606@portrix.net> <20031103143656.GA6785@x30.random>
In-Reply-To: <20031103143656.GA6785@x30.random>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrea Arcangeli wrote:
| On Mon, Nov 03, 2003 at 12:21:59PM +0100, Jan Dittmer wrote:
|
|>I'll give it a try. Is there a way in 2.4-aa to get the two additional
|>virtual processors displayed?
|
|
| No idea why they're not displayed, they should. my HT 2-way xeon shows 4
| cpus not 2 (with 2.4 too).

Strange, if I enable Highmem support and set CONFIG_NR_CPUS from 4 to 8,
4 penguins are showing up...

Jan

- --- config-2.4.23pre6aa3-4proc-nohm     2003-11-03 16:42:15.000000000 
+0100
+++ config-2.4.23pre6aa3-8proc-hm       2003-11-03 16:33:08.000000000 +0100
@@ -58,19 +58,20 @@
~ CONFIG_MICROCODE=m
~ CONFIG_X86_MSR=m
~ CONFIG_X86_CPUID=m
- -CONFIG_NOHIGHMEM=y
- -# CONFIG_HIGHMEM4G is not set
+# CONFIG_NOHIGHMEM is not set
+CONFIG_HIGHMEM4G=y
~ # CONFIG_HIGHMEM64G is not set
- -# CONFIG_HIGHMEM is not set
+CONFIG_HIGHMEM=y
~ CONFIG_FORCE_MAX_ZONEORDER=11
~ CONFIG_1GB=y
~ # CONFIG_2GB is not set
~ # CONFIG_3GB is not set
~ # CONFIG_05GB is not set
+CONFIG_HIGHIO=y
~ # CONFIG_MATH_EMULATION is not set
~ CONFIG_MTRR=y
~ CONFIG_SMP=y
- -CONFIG_NR_CPUS=4
+CONFIG_NR_CPUS=8
~ # CONFIG_X86_NUMA is not set
~ # CONFIG_X86_TSC_DISABLE is not set
~ CONFIG_X86_TSC=y
@@ -1133,6 +1134,7 @@
~ # CONFIG_KMSGDUMP is not set
~ # CONFIG_DEBUG_SPINLOCK is not set
~ # CONFIG_FRAME_POINTER is not set
+# CONFIG_HIGHMEM_EMULATION is not set
~ # CONFIG_X86_REMOTE_DEBUG is not set
~ # CONFIG_KERNEL_DEBUGGING is not set
~ CONFIG_LOG_BUF_SHIFT=17
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/pnfWLqMJRclVKIYRAtf2AJ9qojtJejZCHC62wVpuobM8V7tRVgCdFnka
A60HaWa0hQbG9vCz4+nVtA0=
=ySBx
-----END PGP SIGNATURE-----

