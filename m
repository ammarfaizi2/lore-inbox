Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUFQNBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUFQNBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUFQNBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:01:30 -0400
Received: from camus.xss.co.at ([194.152.162.19]:9234 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S266476AbUFQNB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:01:28 -0400
Message-ID: <40D1961F.7090804@xss.co.at>
Date: Thu, 17 Jun 2004 15:01:19 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre6
References: <20040616183343.GA9940@logos.cnet>
In-Reply-To: <20040616183343.GA9940@logos.cnet>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010701000206060508070808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010701000206060508070808
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcelo,

Marcelo Tosatti wrote:
> Hi,
>
> Here goes -pre6. It contains a significant amount of USB fixes, JFS update,
> netfilter/sctp fixes, CDROM driver update, tg3 update, SPARC/Alpha fixes.
>
> And more importantly the FPU x86/x86-64 crash fix.
>
> Read the detailed changelog for more details.
>
As already reported for -pre5 and still valid for -pre6,
"make xconfig" is broken due to changes in drivers/hotplug/Config.in

The attached (trivial) patch fixes this problem.

HTH

Regards,

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFA0ZYZxJmyeGcXPhERAvJ1AJ0dA82kQ+jk0sdQiF5whMa+nvfxVQCghCGh
JSw80qVZNyIWwUZLslMdJ/k=
=3eBJ
-----END PGP SIGNATURE-----

--------------010701000206060508070808
Content-Type: text/plain;
 name="hotplug_xconfig_HRT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotplug_xconfig_HRT.patch"

--- linux-2.4.27pre6/drivers/hotplug/Config.in.orig	2004-06-17 14:16:42.000000000 +0200
+++ linux-2.4.27pre6/drivers/hotplug/Config.in	2004-06-17 14:40:02.000000000 +0200
@@ -17,7 +17,7 @@
 dep_tristate '  SHPC PCI Hotplug driver' CONFIG_HOTPLUG_PCI_SHPC $CONFIG_HOTPLUG_PCI
 dep_mbool '    Use polling mechanism for hot-plug events (for testing purpose)' CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE $CONFIG_HOTPLUG_PCI_SHPC
 if [ "$CONFIG_ACPI" = "n" ]; then
-dep_mbool '    For AMD SHPC only: Use $HRT for resource/configuration' CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY $CONFIG_HOTPLUG_PCI_SHPC 
+dep_mbool '    For AMD SHPC only: Use HRT for resource/configuration' CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY $CONFIG_HOTPLUG_PCI_SHPC 
 fi
 dep_tristate '  PCI Express Hotplug driver' CONFIG_HOTPLUG_PCI_PCIE $CONFIG_HOTPLUG_PCI
 dep_mbool '    Use polling mechanism for hot-plug events (for testing purpose)' CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE $CONFIG_HOTPLUG_PCI_PCIE

--------------010701000206060508070808--

