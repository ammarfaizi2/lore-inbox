Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268081AbTBRXTf>; Tue, 18 Feb 2003 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268085AbTBRXTf>; Tue, 18 Feb 2003 18:19:35 -0500
Received: from smtp.terra.es ([213.4.129.129]:64213 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id <S268081AbTBRXTe>;
	Tue, 18 Feb 2003 18:19:34 -0500
Date: Wed, 19 Feb 2003 00:29:38 +0100
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: buggy include path?
Message-Id: <20030219002938.08b717c7.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Including include/usb.h from a external module source (out of the kernel tree) causes 
this:
In file included from /home/diego/kernel/unsta/include/linux/irq.h:19,
                 from /home/diego/kernel/unsta/include/asm/hardirq.h:6,
                 from /home/diego/kernel/unsta/include/linux/interrupt.h:9,
                 from /home/diego/kernel/unsta/include/linux/usb.h:15, <- file included
                 from w9968cf.h:38,
                 from w9968cf.c:57:
/home/diego/kernel/unsta/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory

However in include/asm/irq.h you can see:

#include <linux/config.h>
#include <linux/sched.h>
/* include comes from machine specific directory */
#include "irq_vectors.h"

so who is wrong here? This include cames out
of the specific machine directory; but it doesnt
seems a wrong include.

irq_vectors.h is at: include/asm-i386/mach-default/irq_vectors.h



Diego Calleja




