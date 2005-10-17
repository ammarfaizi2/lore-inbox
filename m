Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVJQMlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVJQMlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVJQMlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:41:09 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:6741 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932285AbVJQMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:41:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Message-Id;
  b=vjtqjgXM2OgyusxkYVtWCEtIIOCES5bdw/UDX5CUQltTnJ+6unudXxAon0dnQgUBTWKJ1Fn2f8FRpJpT8moa40CvuKnhpGOPid8H3+gf+tcWm6VkD6O+O3vw424txb5adXvDXxquFeaS1f+zLUdeTE33OFg32MKEIaJNUysH/Og=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] 2.6.14-rc4-rt6 x86_64 two timer entries in /sys
Date: Mon, 17 Oct 2005 14:47:32 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k15UDOhoaQEGaCA"
Message-Id: <200510171447.32375.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_k15UDOhoaQEGaCA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ingo,

attached patch renames one instance of
	/sys/devices/system/timer
to
	/sys/devices/system/timer_pit
to avoid a name clash with another instance created in time.c.

      Karsten

--Boundary-00=_k15UDOhoaQEGaCA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch_x86_64-kernel-i8259"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_x86_64-kernel-i8259"

--- rc4-rt6/arch/x86_64/kernel/i8259.c	2005-10-17 13:31:44.000000000 +0200
+++ rc4-rt6-kw/arch/x86_64/kernel/i8259.c	2005-10-17 14:31:25.000000000 +0200
@@ -515,7 +515,7 @@
 }
 
 static struct sysdev_class timer_sysclass = {
-	set_kset_name("timer"),
+	set_kset_name("timer_pit"),
 	.resume		= timer_resume,
 };
 

--Boundary-00=_k15UDOhoaQEGaCA--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
