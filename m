Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274038AbRISLcA>; Wed, 19 Sep 2001 07:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274037AbRISLbu>; Wed, 19 Sep 2001 07:31:50 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:53514 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274035AbRISLbk>;
	Wed, 19 Sep 2001 07:31:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: henrik@hswn.dk
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.4.10pre12: IO_APIC_init_uniprocessor undefined 
In-Reply-To: Your message of "Wed, 19 Sep 2001 10:52:40 +0200."
             <20010919105240.A11535@hswn.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Sep 2001 21:30:53 +1000
Message-ID: <22474.1000899053@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001 10:52:40 +0200, 
<henrik@hswn.dk> wrote:
>Compiling without SMP but with "APIC and IO-APIC support on
>uniprocessors" enabled, i.e.
>fails with IO_APIC_init_uniprocessor undefined.

Index: 10-pre12.1/init/main.c
--- 10-pre12.1/init/main.c Fri, 06 Jul 2001 09:49:24 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3 644)
+++ 10-pre12.1(w)/init/main.c Wed, 19 Sep 2001 21:28:17 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3 644)
@@ -483,7 +483,7 @@ extern void cpu_idle(void);
 #ifdef CONFIG_X86_IO_APIC
 static void __init smp_init(void)
 {
-	IO_APIC_init_uniprocessor();
+	APIC_init_uniprocessor();
 }
 #else
 #define smp_init()	do { } while (0)

