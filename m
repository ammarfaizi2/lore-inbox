Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbTBTW7y>; Thu, 20 Feb 2003 17:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTBTW7y>; Thu, 20 Feb 2003 17:59:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:39299 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267143AbTBTW7u>; Thu, 20 Feb 2003 17:59:50 -0500
Date: Fri, 21 Feb 2003 00:09:53 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.62-ac1
Message-ID: <20030220230953.GH1426@louise.pinerecords.com>
References: <20030220230507.GG1426@louise.pinerecords.com> <200302202306.h1KN66c17134@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202306.h1KN66c17134@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@redhat.com]
> 
> > Alan, this doesn't boot in my vmware setup while 2.5.62 vanilla does
> > (same config where applicable).  Never gets to do anything after
> > 'Uncompressing Linux... Ok, booting the kernel.'  Any off-hand suspects?
> 
> Curious. And its definitely not turned console support back off in the
> make config ?

$ diff -u 2.5.62/.config 2.5.62-ac1/.config
--- 2.5.62/.config	2003-02-18 09:35:12.000000000 +0100
+++ 2.5.62-ac1/.config	2003-02-20 23:55:10.000000000 +0100
@@ -19,6 +19,8 @@
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
 CONFIG_MORSE_PANICS=y
 
 #
@@ -39,6 +41,7 @@
 # CONFIG_X86_NUMAQ is not set
 # CONFIG_X86_SUMMIT is not set
 # CONFIG_X86_BIGSMP is not set
+# CONFIG_X86_VISWS is not set
 # CONFIG_M386 is not set
 # CONFIG_M486 is not set
 # CONFIG_M586 is not set
@@ -850,6 +853,10 @@
 CONFIG_DUMMY_CONSOLE=y
 
 #
+# Logo configuration
+#
+
+#
 # Sound
 #
 # CONFIG_SOUND is not set
@@ -902,3 +909,7 @@
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
 CONFIG_X86_BIOS_REBOOT=y
+
+#
+# Hardware Abstraction Layer
+#

> Do you have pretty flashing keyboard lights ?

Nothing I'm afraid.

-- 
Tomas Szepe <szepe@pinerecords.com>
