Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbSL3VRN>; Mon, 30 Dec 2002 16:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbSL3VRN>; Mon, 30 Dec 2002 16:17:13 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:13703 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267083AbSL3VRL> convert rfc822-to-8bit; Mon, 30 Dec 2002 16:17:11 -0500
Message-Id: <4.3.2.7.2.20021230213831.00b5b250@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 30 Dec 2002 22:26:05 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Cc: joergprante@netcologne.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,
	No, the defines in sched.h are surrounded by #idef CONFIG_PREEMPT
	before #ifdef CONFIG_PREEMPT_LOG and therefore don't bite.
	You need the #ifdef CONFIG_PREEMPT_LOG around the
	sysrq_handle_preempt_log and the following sysrq_key_op sysrq_preempt_log_op
	functions as per later in the code :
	#ifdef CONFIG_PREEMPT_LOG
	/* g */ &sysrq_preempt_log_op,
	#else
	/* g */ NULL,
	#endif


	Next problems :

scx200.c:117: parse error before 
"this_object_must_be_defined_as_export_objs_in_the_Makefile"
scx200.c:117: warning: type defaults to `int' in declaration of 
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
scx200.c:117: warning: data definition has no type or storage class
scx200.c:118: parse error before 
"this_object_must_be_defined_as_export_objs_in_the_Makefile"
scx200.c:118: warning: type defaults to `int' in declaration of 
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
scx200.c:118: warning: data definition has no type or storage class
scx200.c:119: parse error before 
"this_object_must_be_defined_as_export_objs_in_the_Makefile"
scx200.c:119: warning: type defaults to `int' in declaration of 
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
scx200.c:119: warning: data definition has no type or storage class
scx200.c:120: parse error before 
"this_object_must_be_defined_as_export_objs_in_the_Makefile"
scx200.c:120: warning: type defaults to `int' in declaration of 
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
scx200.c:120: warning: data definition has no type or storage class
scx200.c:121: parse error before 
"this_object_must_be_defined_as_export_objs_in_the_Makefile"
scx200.c:121: warning: type defaults to `int' in declaration of 
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
scx200.c:121: warning: data definition has no type or storage class
make[2]: *** [scx200.o] Error 1
make[2]: Leaving directory `/var/tmp/linux-2.4.20/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/var/tmp/linux-2.4.20/drivers'
make: *** [_mod_drivers] Error 2


find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.21mw0; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21mw0/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
depmod: *** Unresolved symbols in /lib/modules/2.4.21mw0/kernel/net/irda/irda.o
depmod:         irlmp_lap_tx_queue_full


Margit

