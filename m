Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbTCGVxV>; Fri, 7 Mar 2003 16:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbTCGVxV>; Fri, 7 Mar 2003 16:53:21 -0500
Received: from 205-158-62-74.outblaze.com ([205.158.62.74]:41681 "HELO
	ws5-8.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261806AbTCGVxS>; Fri, 7 Mar 2003 16:53:18 -0500
Message-ID: <20030307220337.5841.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: ciarrocchi@linuxmail.org
Date: Sat, 08 Mar 2003 06:03:37 +0800
Subject: [RFC] one line fix in arch/i386/Kconfig
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
this is the first time I post a patch to the list,
therefore I'm really not sure if it is correct,
even if it is just a 'one line patch'

If I say that my cpu is not a PentiumIV why
he bothers me about "check for P4 thermal throttling interrupt." ?

This patch show that option only if you select that kind of CPU.

Is it correct ? Does it makes sense ?

Ciao,
		Paolo
		


--- arch/i386/Kconfig.orig	2003-03-07 22:17:58.000000000 +0100
+++ arch/i386/Kconfig	2003-03-07 22:19:29.000000000 +0100
@@ -536,7 +536,7 @@
 
 config X86_MCE_P4THERMAL
 	bool "check for P4 thermal throttling interrupt."
-	depends on X86_MCE && (X86_UP_APIC || SMP)
+	depends on X86_MCE && (X86_UP_APIC || SMP) && MPENTIUM4
 	help
 	  Enabling this feature will cause a message to be printed when the P4
 	  enters thermal throttling.

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
