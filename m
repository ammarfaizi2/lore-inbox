Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUHJPqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUHJPqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUHJPqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:46:50 -0400
Received: from mail.aei.ca ([206.123.6.14]:59610 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267488AbUHJPqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:46:10 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Shane Shrybman <shane@zeke.yi.org>
To: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1092152765.2630.43.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 11:46:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ Ingo Molnar wrote ]
-O5 fixes the APIC lockup issues. The bug was primarily caused by PCI 
POST delays causing IRQ storms of level-triggered IRQ sources that were 
hardirq-redirected. Also found some bugs in delayed-IRQ masking and 
unmasking. SMP should thus work again too. 

Indeed, -O5 is running fine here with all APIC options enabled. Great
work, thanks!

--- linux-2.6.8-rc3-O5/Makefile.orig	2004-08-10 11:17:29.000000000 -0400
+++ linux-2.6.8-rc3-O5/Makefile	2004-08-10 11:14:55.000000000 -0400
@@ -1,8 +1,8 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 8
-EXTRAVERSION =-rc3
-NAME=Zonked Quokka
+EXTRAVERSION =-rc3-O5
+NAME=Smooth as Ex-Lax
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"

;)

Shane

