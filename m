Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWH3XMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWH3XMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWH3XMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:12:44 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:28299 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751614AbWH3XMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:12:43 -0400
Date: Wed, 30 Aug 2006 19:12:42 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 1/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830231242.GB17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-29580-1156979562-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:10:48 up 7 days, 20:19,  9 users,  load average: 0.69, 0.26, 0.20
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-29580-1156979562-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The "Core" patches (1-6) must all be applied to have a compilable kernel.

Applying those patches will install the core tracing infrastructure to the
Linux kernel.

1- Minor Makefile modification :
patch-2.6.17-lttng-0.5.95-build.diff


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-29580-1156979562-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-build.diff"

--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,9 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION =
+EXTRAVERSION =-lttng-0.5.95
 NAME=Crazed Snow-Weasel
+NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
@@ -518,7 +519,7 @@ export MODLIB
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ ltt/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 08b7cc9..feac13c 100644

--=_Krystal-29580-1156979562-0001-2--
