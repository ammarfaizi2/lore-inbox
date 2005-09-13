Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVIMVca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVIMVca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVIMVca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:32:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6081 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932521AbVIMVc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:32:29 -0400
Message-Id: <200509132132.j8DLW0XC032735@laptop11.inf.utfsm.cl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Roland Dreier <rolandd@cisco.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1 
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Tue, 13 Sep 2005 11:46:06 MST." <Pine.LNX.4.58.0509131144300.3351@g5.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 13 Sep 2005 17:32:00 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 13 Sep 2005 17:32:01 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the big "no more merges" push of stuff into 2.6.14-rc1 on i686 I get:

   arch/i386/kernel/built-in.o: In function `parse_cmdline_early':
   : undefined reference to `disable_timer_pin_1'
   arch/i386/kernel/built-in.o: In function `parse_cmdline_early':
   : undefined reference to `disable_timer_pin_1'
   arch/i386/kernel/built-in.o: In function `parse_cmdline_early':
   : undefined reference to `disable_timer_pin_1'

In io_apic.c there is an:

   int disable_timer_pin_1 __initdata;

but that file isn't compiled here, as CONFIG_X86_IO_APIC isn't set; while
the pieces that reference this are protected by CONFIG_X86_LOCAL_APIC. An
option changed name, perhaps?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

