Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWF0Wkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWF0Wkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWF0Wkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:40:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422693AbWF0Wkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:40:40 -0400
Date: Wed, 28 Jun 2006 00:40:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rmk@arm.linux.org.uk
Subject: 2.6.17-mm3: arm: *_irq_wake compile error
Message-ID: <20060627224038.GF13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

genirq-add-irq-wake-power-management-support.patch causes the following 
compile error on arm:

<--  snip  -->

...
  CC      init/main.o
In file included from include/linux/rtc.h:102,
                 from include/linux/efi.h:19,
                 from init/main.c:47:
include/linux/interrupt.h:108: error: conflicting types for 'enable_irq_wake'
include/asm/irq.h:47: error: previous declaration of 'enable_irq_wake' was here
include/linux/interrupt.h:113: error: conflicting types for 'disable_irq_wake'
include/asm/irq.h:46: error: previous declaration of 'disable_irq_wake' was here
make[1]: *** [init/main.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


