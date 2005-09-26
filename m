Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVIZMKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVIZMKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVIZMKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:10:24 -0400
Received: from web51004.mail.yahoo.com ([206.190.38.135]:10376 "HELO
	web51004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751437AbVIZMKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:10:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vpFBDvABUBiKY1NMM04Zt7ASejQXl48Uw5BeRzpfc4MQhzAGpsD15ddh8TlFfzsbFqh5GNQbw0IN3MZr62ScehhSPXDoDS2H1hee2ao1tszzsvnYUENGiXhDMEmfy8VczQwr01vmE8alCW1k1tNsdHRFWMhu+PnSFuSIBWgx8pI=  ;
Message-ID: <20050926121018.53577.qmail@web51004.mail.yahoo.com>
Date: Mon, 26 Sep 2005 05:10:18 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: [PATCH](Makefile) Automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux.org/scripts/kconfig/Makefile	2005-09-23
09:27:39.000000000 +0200
+++ linux-2.6.13.2/scripts/kconfig/Makefile	2005-09-25
21:42:18.000000000 +0200
@@ -17,6 +17,14 @@
 config: $(obj)/conf
 	$< arch/$(ARCH)/Kconfig
 
+autoconfig: $(obj)/conf
+	@if [ -f .config ]; then  rm .config; fi;
+	$< -a arch/$(ARCH)/Kconfig
+
+autochoiceconfig: $(obj)/conf
+	@if [ -f .config ]; then  rm .config; fi;
+	$< -c arch/$(ARCH)/Kconfig
+
 oldconfig: $(obj)/conf
 	$< -o arch/$(ARCH)/Kconfig
 
@@ -67,7 +75,8 @@
 	@echo  '  allmodconfig	  - New config selecting
modules when possible'
 	@echo  '  allyesconfig	  - New config where all
options are accepted with yes'
 	@echo  '  allnoconfig	  - New minimal config'
-
+	@echo  '  autoconfig	  - New config with
automatically answer to elected-options based on the
System'
+	@echo  '  autochoiceconfig - New config like
autoconfig, but the user will be asked for including
the elected-options' 
 #
===========================================================================
 # Shared Makefile for the various kconfig
executables:
 # conf:	  Used for defconfig, oldconfig and related
targets




		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
