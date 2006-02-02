Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWBBQOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWBBQOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBBQOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:14:46 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:26124 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932104AbWBBQOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:14:45 -0500
Message-ID: <43E23054.8090002@sw.ru>
Date: Thu, 02 Feb 2006 19:16:20 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: [RFC][PATCH 1/7] VPIDs: add VPID config option
References: <43E22B2D.1040607@openvz.org>
In-Reply-To: <43E22B2D.1040607@openvz.org>
Content-Type: multipart/mixed;
 boundary="------------010200080105090106090509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010200080105090106090509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Add CONFIG_VIRTUAL_PIDS config option. Too simple one.

Kirill

--------------010200080105090106090509
Content-Type: text/plain;
 name="diff-vpids-conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-vpids-conf"

--- ./init/Kconfig.vpid_conf	2006-02-02 14:15:35.145785768 +0300
+++ ./init/Kconfig	2006-02-02 14:31:22.904704512 +0300
@@ -316,6 +316,15 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
 
+config VIRTUAL_PIDS
+	default n
+	bool "Enable virtual pids support"
+	help
+	  This option turns on process' ids virtualisation. Each
+	  task has two types of pids assigned - system and virtual.
+	  The latter is the one visible to user-space. When off
+	  virtual pid is always equal to system one.
+
 config BUG
 	bool "BUG() support" if EMBEDDED
 	default y

--------------010200080105090106090509--

