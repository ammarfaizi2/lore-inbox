Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266357AbSKGFPa>; Thu, 7 Nov 2002 00:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266360AbSKGFPa>; Thu, 7 Nov 2002 00:15:30 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:27127 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S266357AbSKGFP3>; Thu, 7 Nov 2002 00:15:29 -0500
Message-ID: <3DC9EA2A.142559AA@verizon.net>
Date: Wed, 06 Nov 2002 20:20:58 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davem@redhat.com, linux-kernel@vger.kernel.org
CC: ahu@ds9a.nl
Subject: Re: Silly advise in bridge Configure help
Content-Type: multipart/mixed;
 boundary="------------BF09BD75E4373F9F2836F7EA"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [4.64.197.173] at Wed, 6 Nov 2002 23:22:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BF09BD75E4373F9F2836F7EA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bert Hubert said a few days back:
| In the Configure HELP of Ethernet bridging:
|
| "Note that if your box acts as a bridge, it probably contains 
| several Ethernet devices, but the kernel is not able to recognize
| more than one at
| boot time without help; for details read the Ethernet-HOWTO, 
| available from in <http://www.linuxdoc.org/docs.html#howto>."
|
| This is extremely bogus these days and prone to confuse people. 
| I suggest this warning is removed.

Sounds good, so here's the patch to 2.5.46 Kconfig to do that
if you want it.

~Randy
--------------BF09BD75E4373F9F2836F7EA
Content-Type: text/plain; charset=us-ascii;
 name="bridge_help-2.5.46.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bridge_help-2.5.46.patch"

--- ./net/Kconfig%fixhelp	Mon Nov  4 14:30:05 2002
+++ ./net/Kconfig	Wed Nov  6 20:07:13 2002
@@ -382,11 +382,6 @@
 	  for location. Please read the Bridge mini-HOWTO for more
 	  information.
 
-	  Note that if your box acts as a bridge, it probably contains several
-	  Ethernet devices, but the kernel is not able to recognize more than
-	  one at boot time without help; for details read the Ethernet-HOWTO,
-	  available from in <http://www.linuxdoc.org/docs.html#howto>.
-
 	  If you want to compile this code as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
 	  say M here and read <file:Documentation/modules.txt>.  The module

--------------BF09BD75E4373F9F2836F7EA--

