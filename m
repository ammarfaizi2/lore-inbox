Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318140AbSGMKfJ>; Sat, 13 Jul 2002 06:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSGMKfI>; Sat, 13 Jul 2002 06:35:08 -0400
Received: from t4o53p48.telia.com ([62.20.229.168]:13184 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S318140AbSGMKfH>;
	Sat, 13 Jul 2002 06:35:07 -0400
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac3
References: <200207121914.g6CJEcN32497@devserv.devel.redhat.com>
	<m2znwwikcj.fsf@best.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2002 12:25:28 +0200
In-Reply-To: <m2znwwikcj.fsf@best.localdomain>
Message-ID: <m2ele7vs9z.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Alan Cox <alan@redhat.com> writes:
> 
> > o	Update cpufreq, add PIV throttling		(Robert Schwebel,
> > 			Padraig Brady, Zwane Mwaikambo, Arjan van de Ven,
> > 			Tora Engstad)
> 
> It doesn't work because of a bug in cpufreq_p4_validatedc. Here is a
> patch to fix it:

I forgot to mention that this patch is also needed:

--- linux/kernel/Makefile.orig	Sat Jul 13 12:10:29 2002
+++ linux/kernel/Makefile	Sat Jul 13 12:10:46 2002
@@ -19,6 +19,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
