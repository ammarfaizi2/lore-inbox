Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWHXLpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWHXLpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWHXLpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:45:13 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:20597 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751170AbWHXLpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:45:10 -0400
Message-ID: <44ED91EB.9020306@sw.ru>
Date: Thu, 24 Aug 2006 15:47:55 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Rik van Riel <riel@redhat.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Rohit Seth <rohitseth@google.com>, Matt Helsley <matthltc@us.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 1/6] BC: kconfig
References: <44EC31FB.2050002@sw.ru>  <44EC35A3.7070308@sw.ru> <1156379028.7154.25.camel@linuxchandra>
In-Reply-To: <1156379028.7154.25.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a reason why these can be moved to a arch-neutral place ?
I think a good place for BC would be kernel/Kconfig.bc
but still this should be added into archs.
ok?

> PS: Please keep ckrm-tech on Cc: please.
Sorry, it is very hard to track emails coming from authors and 3 mailing lists.
Better tell me the interested people emails.

Thanks,
Kirill

> 
> On Wed, 2006-08-23 at 15:01 +0400, Kirill Korotaev wrote:
> 
>>Add kernel/bc/Kconfig file with BC options and
>>include it into arch Kconfigs
>>
>>Signed-off-by: Pavel Emelianov <xemul@sw.ru>
>>Signed-off-by: Kirill Korotaev <dev@sw.ru>
>>
>>---
>>
>> arch/i386/Kconfig    |    2 ++
>> arch/ia64/Kconfig    |    2 ++
>> arch/powerpc/Kconfig |    2 ++
>> arch/ppc/Kconfig     |    2 ++
>> arch/sparc/Kconfig   |    2 ++
>> arch/sparc64/Kconfig |    2 ++
>> arch/x86_64/Kconfig  |    2 ++
>> kernel/bc/Kconfig    |   25 +++++++++++++++++++++++++
>> 8 files changed, 39 insertions(+)
>>
>>--- ./arch/i386/Kconfig.bckm	2006-07-10 12:39:10.000000000 +0400
>>+++ ./arch/i386/Kconfig	2006-07-28 14:10:41.000000000 +0400
>>@@ -1146,6 +1146,8 @@ source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> #
>> # Use the generic interrupt handling code in kernel/irq/:
>> #
>>--- ./arch/ia64/Kconfig.bckm	2006-07-10 12:39:10.000000000 +0400
>>+++ ./arch/ia64/Kconfig	2006-07-28 14:10:56.000000000 +0400
>>@@ -481,6 +481,8 @@ source "fs/Kconfig"
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> #
>> # Use the generic interrupt handling code in kernel/irq/:
>> #Add kernel/bc/Kconfig file with BC options and
>>include it into arch Kconfigs
>>
>>Signed-off-by: Pavel Emelianov <xemul@sw.ru>
>>Signed-off-by: Kirill Korotaev <dev@sw.ru>
>>
>>---
>>
>> arch/i386/Kconfig    |    2 ++
>> arch/ia64/Kconfig    |    2 ++
>> arch/powerpc/Kconfig |    2 ++
>> arch/ppc/Kconfig     |    2 ++
>> arch/sparc/Kconfig   |    2 ++
>> arch/sparc64/Kconfig |    2 ++
>> arch/x86_64/Kconfig  |    2 ++
>> kernel/bc/Kconfig    |   25 +++++++++++++++++++++++++
>> 8 files changed, 39 insertions(+)
>>
>>--- ./arch/i386/Kconfig.bckm	2006-07-10 12:39:10.000000000 +0400
>>+++ ./arch/i386/Kconfig	2006-07-28 14:10:41.000000000 +0400
>>@@ -1146,6 +1146,8 @@ source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> #
>> # Use the generic interrupt handling code in kernel/irq/:
>> #
>>--- ./arch/ia64/Kconfig.bckm	2006-07-10 12:39:10.000000000 +0400
>>+++ ./arch/ia64/Kconfig	2006-07-28 14:10:56.000000000 +0400
>>@@ -481,6 +481,8 @@ source "fs/Kconfig"
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> #
>> # Use the generic interrupt handling code in kernel/irq/:
>> #
>>--- ./arch/powerpc/Kconfig.arkcfg	2006-08-07 14:07:12.000000000 +0400
>>+++ ./arch/powerpc/Kconfig	2006-08-10 17:55:58.000000000 +0400
>>@@ -1038,6 +1038,8 @@ source "arch/powerpc/platforms/iseries/K
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> menu "Instrumentation Support"
>>         depends on EXPERIMENTAL
>> 
>>--- ./arch/ppc/Kconfig.arkcfg	2006-07-10 12:39:10.000000000 +0400
>>+++ ./arch/ppc/Kconfig	2006-08-10 17:56:13.000000000 +0400
>>@@ -1414,6 +1414,8 @@ endmenu
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> source "arch/powerpc/oprofile/Kconfig"
>> 
>> source "arch/ppc/Kconfig.debug"
>>--- ./arch/sparc/Kconfig.arkcfg	2006-04-21 11:59:32.000000000 +0400
>>+++ ./arch/sparc/Kconfig	2006-08-10 17:56:24.000000000 +0400
>>@@ -296,3 +296,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
>>--- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
>>+++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
>>@@ -432,3 +432,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
>>--- ./arch/x86_64/Kconfig.bckm	2006-07-10 12:39:11.000000000 +0400
>>+++ ./arch/x86_64/Kconfig	2006-07-28 14:10:49.000000000 +0400
>>@@ -655,3 +655,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
>>--- ./kernel/bc/Kconfig.bckm	2006-07-28 13:07:38.000000000 +0400
>>+++ ./kernel/bc/Kconfig	2006-07-28 13:09:51.000000000 +0400
>>@@ -0,0 +1,25 @@
>>+#
>>+# Resource beancounters (BC)
>>+#
>>+# Copyright (C) 2006 OpenVZ. SWsoft Inc
>>+
>>+menu "User resources"
>>+
>>+config BEANCOUNTERS
>>+	bool "Enable resource accounting/control"
>>+	default n
>>+	help 
>>+          This patch provides accounting and allows to configure
>>+          limits for user's consumption of exhaustible system resources.
>>+          The most important resource controlled by this patch is unswappable 
>>+          memory (either mlock'ed or used by internal kernel structures and 
>>+          buffers). The main goal of this patch is to protect processes
>>+          from running short of important resources because of an accidental
>>+          misbehavior of processes or malicious activity aiming to ``kill'' 
>>+          the system. It's worth to mention that resource limits configured 
>>+          by setrlimit(2) do not give an acceptable level of protection 
>>+          because they cover only small fraction of resources and work on a 
>>+          per-process basis.  Per-process accounting doesn't prevent malicious
>>+          users from spawning a lot of resource-consuming processes.
>>+
>>+endmenu
>>
>>--- ./arch/powerpc/Kconfig.arkcfg	2006-08-07 14:07:12.000000000 +0400
>>+++ ./arch/powerpc/Kconfig	2006-08-10 17:55:58.000000000 +0400
>>@@ -1038,6 +1038,8 @@ source "arch/powerpc/platforms/iseries/K
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> menu "Instrumentation Support"
>>         depends on EXPERIMENTAL
>> 
>>--- ./arch/ppc/Kconfig.arkcfg	2006-07-10 12:39:10.000000000 +0400
>>+++ ./arch/ppc/Kconfig	2006-08-10 17:56:13.000000000 +0400
>>@@ -1414,6 +1414,8 @@ endmenu
>> 
>> source "lib/Kconfig"
>> 
>>+source "kernel/bc/Kconfig"
>>+
>> source "arch/powerpc/oprofile/Kconfig"
>> 
>> source "arch/ppc/Kconfig.debug"
>>--- ./arch/sparc/Kconfig.arkcfg	2006-04-21 11:59:32.000000000 +0400
>>+++ ./arch/sparc/Kconfig	2006-08-10 17:56:24.000000000 +0400
>>@@ -296,3 +296,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
>>--- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
>>+++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
>>@@ -432,3 +432,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
>>--- ./arch/x86_64/Kconfig.bckm	2006-07-10 12:39:11.000000000 +0400
>>+++ ./arch/x86_64/Kconfig	2006-07-28 14:10:49.000000000 +0400
>>@@ -655,3 +655,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
>>--- ./kernel/bc/Kconfig.bckm	2006-07-28 13:07:38.000000000 +0400
>>+++ ./kernel/bc/Kconfig	2006-07-28 13:09:51.000000000 +0400
>>@@ -0,0 +1,25 @@
>>+#
>>+# Resource beancounters (BC)
>>+#
>>+# Copyright (C) 2006 OpenVZ. SWsoft Inc
>>+
>>+menu "User resources"
>>+
>>+config BEANCOUNTERS
>>+	bool "Enable resource accounting/control"
>>+	default n
>>+	help 
>>+          This patch provides accounting and allows to configure
>>+          limits for user's consumption of exhaustible system resources.
>>+          The most important resource controlled by this patch is unswappable 
>>+          memory (either mlock'ed or used by internal kernel structures and 
>>+          buffers). The main goal of this patch is to protect processes
>>+          from running short of important resources because of an accidental
>>+          misbehavior of processes or malicious activity aiming to ``kill'' 
>>+          the system. It's worth to mention that resource limits configured 
>>+          by setrlimit(2) do not give an acceptable level of protection 
>>+          because they cover only small fraction of resources and work on a 
>>+          per-process basis.  Per-process accounting doesn't prevent malicious
>>+          users from spawning a lot of resource-consuming processes.
>>+
>>+endmenu

