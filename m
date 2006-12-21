Return-Path: <linux-kernel-owner+w=401wt.eu-S1422808AbWLUIfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWLUIfb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422828AbWLUIfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:35:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:65192 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422808AbWLUIfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:35:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:from;
        b=mJNUKC9cfRxnFWjD3s5CKi/6U1WenXNhx+BwpW+c1DP9BrDsJx6JXBF0XpAVe1Kb/ye6lM+wevQlGVNv/agspm5OQ394MWJ+Z6xdsQ8KNfg6MVkGcLM4r6lxoP0nunC0Xwch4CHM7782wUGajmOD5Fx0wwQYvxfrikTKrezua1c=
Message-ID: <458A474F.2060007@gmail.com>
Date: Thu, 21 Dec 2006 09:35:27 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH -rt 2/4] ARM: NO_HZ support
Content-Type: multipart/mixed;
 boundary="------------000101010104040508050002"
From: Dirk Behme <dirk.behme@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000101010104040508050002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ARM: NO_HZ support

This is an update of the initial patch from Daniel Walker
and Kevin Hilman.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------000101010104040508050002
Content-Type: text/plain;
 name="arm-no-hz-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm-no-hz-patch.txt"

Index: linux-2.6.20-rc1/arch/arm/Kconfig
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/Kconfig
+++ linux-2.6.20-rc1/arch/arm/Kconfig
@@ -529,6 +529,7 @@ source kernel/Kconfig.preempt
 
 config NO_IDLE_HZ
 	bool "Dynamic tick timer"
+	depends on !GENERIC_CLOCKEVENTS
 	help
 	  Select this option if you want to disable continuous timer ticks
 	  and have them programmed to occur as required. This option saves


--------------000101010104040508050002--
