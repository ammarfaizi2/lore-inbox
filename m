Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUKBKKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUKBKKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 05:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUKBJx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:53:59 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:57738 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261227AbUKBJov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:44:51 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: [Patch] bonding.txt documentation patch
Date: Tue, 2 Nov 2004 10:49:26 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411020949.26586.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.49; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

diff -Nurd linux-2.6.9/Documentation/networking/bonding.txt 
linux-2.6.9-mrw/Documentation/networking/bonding.txt
- --- linux-2.6.9/Documentation/networking/bonding.txt    2004-10-18 
22:53:45.000000000 +0100
+++ linux-2.6.9-mrw/Documentation/networking/bonding.txt        2004-11-02 
09:48:05.831738136 +0000
@@ -418,17 +418,27 @@
 driver multiple times allows each instance of the driver to have differing
 options.

+Note: 2.6 kernel modules are capable of being loaded multiple times without
+being explicitly loaded twice. The bonding.o driver however, defaults to
+only allowing you to load it once, unless you use the max_bonds parameter.
+Using "-o bonding1" is depreciated for 2.6 kernels.
+
 For example, to configure two bonding interfaces, one with mii link
 monitoring performed every 100 milliseconds, and one with ARP link
- -monitoring performed every 200 milliseconds, the /etc/conf.modules should
+monitoring performed every 200 milliseconds, the /etc/modprobe.conf should
 resemble the following:

 alias bond0 bonding
 alias bond1 bonding

+# For Kernel 2.4 (/etc/modules.conf or conf.modules):
 options bond0 miimon=100
 options bond1 -o bonding1 arp_interval=200 arp_ip_target=10.0.0.1

+# for Kernel 2.6:
+options bond0 miimon=100 max_bonds=2
+options bond1 arp_interval=200 arp_ip_target=10.0.0.1
+
 Configuring Multiple ARP Targets
 ================================


- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBh1gmBn4EFUVUIO0RAlU9AJ9KvQAODtingQYSIfRjorvsvlVmxQCgwnVr
JbiVbefW1TNxDl4aTBsGfGg=
=D8Gz
-----END PGP SIGNATURE-----
