Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281499AbRKHJ0B>; Thu, 8 Nov 2001 04:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281494AbRKHJZx>; Thu, 8 Nov 2001 04:25:53 -0500
Received: from david.siemens.de ([192.35.17.14]:49397 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S281506AbRKHJZk>;
	Thu, 8 Nov 2001 04:25:40 -0500
Message-ID: <3BEA4F90.678EF402@infineon.com>
Date: Thu, 08 Nov 2001 10:25:36 +0100
From: Philipp Boerker <philipp.boerker@infineon.com>
Reply-To: philipp.boerker@infineon.com
X-Mailer: Mozilla 4.78 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 does not compile without SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have several problems with the 2.4.14 (and I know about
the loop.o-fix already ;).

It is normal behaviour that AMP does not work when SMP
is activated. That's why I don't want any SMP stuff on
my laptop which would be unnecessary anyway. But 
deactivating the SMP option causes the compilation to 
fail:

In file included from ksyms.c:17:
/usr/src/linux-2.4.14/include/linux/kernel_stat.h: 
In function `kstat_irqs':
/usr/src/linux-2.4.14/include/linux/kernel_stat.h:48: 
`smp_num_cpus' undeclared (first use in this function)


Do I make something wrong? I replaced smp_num_cpus with 0
since this seemed to make sense to me as I have a single
processor machine. The compile continued but aborted with
another error...


-- 
Philipp Boerker   -   Mixed-signals ICs Design Engineer
Infineon Technologies AG, COM ANS, MchB/KU II, R.910906
Rosenheimer Str. 116                     81669 Muenchen
phone: +49 89 234 54 725         fax: +49 89 234 85 664
