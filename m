Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVFVOOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVFVOOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFVOOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:14:25 -0400
Received: from village.ehouse.ru ([193.111.92.18]:15110 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261296AbVFVOOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:14:20 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 hangs on boot
Date: Wed, 22 Jun 2005 18:13:49 +0400
User-Agent: KMail/1.8.1
Cc: admin@list.net.ru
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506221813.50385.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G' day

I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8 GHz
[ MoBo: Intel E7520, intel 82801 ]
but kernel hangs on boot right after records:

Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
Initializing CPU#2

( below is a link to full boot trace, actually -git3 but no differences)
http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-hang

An attempt to enable debug:
+CONFIG_ACPI_DEBUG=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DEBUG_PREEMPT=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_SPINLOCK_SLEEP=y
+CONFIG_DEBUG_KOBJECT=y
+CONFIG_DEBUG_INFO=y
+CONFIG_INIT_DEBUG=y
gives rather strange result, kernel boots successfully ( with a lot of
debuging messages of course but i couldn't find something suspicious )
http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-debug

config for 2.6.12 have been taken from previous one, only
'make oldconfig' has been made.
http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3.config

Hang 100% reproducible on at least two of my EM64T hosts.
( actualy the same configuration as of MoBo/CPU )

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
