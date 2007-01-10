Return-Path: <linux-kernel-owner+w=401wt.eu-S964830AbXAJKYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbXAJKYp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 05:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbXAJKYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 05:24:45 -0500
Received: from miranda.se.axis.com ([193.13.178.8]:35411 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964830AbXAJKYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 05:24:45 -0500
X-Greylist: delayed 1388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 05:24:44 EST
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Cc: "Edgar Iglesias" <edgar.iglesias@axis.com>
Subject: Iptable loop during kernel startup
Date: Wed, 10 Jan 2007 11:01:34 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B5903@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kernel with

CONFIG_IP_NF_TABLES=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_LOG=y

all other NF options are off.

During kernel startup I get
iptables: loop hook 1 pos 00000022

when filter tries to register at module_init.

Any ideas why I get this loop?

/Mikael

