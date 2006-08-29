Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWH2PTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWH2PTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWH2PTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:19:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:35782 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964820AbWH2PTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:19:09 -0400
Message-ID: <44F45AE2.6000309@fr.ibm.com>
Date: Tue, 29 Aug 2006 17:18:58 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: 2.6.18-rc4-mm3
References: <20060826160922.3324a707.akpm@osdl.org> <20060829153700.309334d6@cad-250-152.norway.atmel.com>
In-Reply-To: <20060829153700.309334d6@cad-250-152.norway.atmel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haavard Skinnemoen wrote:
> On Sat, 26 Aug 2006 16:09:22 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
>> +namespaces-add-nsproxy-move-init_nsproxy-into-kernel-nsproxyc.patch
> 
> This causes a multiple definition of init_nsproxy on AVR32. Reverting
> namespaces-add-nsproxy-avr32-fix.patch fixes it.

Could you try this ?

thanks,

C.


Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 arch/avr32/kernel/init_task.c |    2 --
 1 file changed, 2 deletions(-)

Index: 2.6.18-rc4-mm3/arch/avr32/kernel/init_task.c
===================================================================
--- 2.6.18-rc4-mm3.orig/arch/avr32/kernel/init_task.c
+++ 2.6.18-rc4-mm3/arch/avr32/kernel/init_task.c
@@ -10,7 +10,6 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>

 #include <asm/pgtable.h>

@@ -19,7 +18,6 @@ static struct files_struct init_files =
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);

 EXPORT_SYMBOL(init_mm);

