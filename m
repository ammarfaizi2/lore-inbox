Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131241AbRCHAov>; Wed, 7 Mar 2001 19:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131247AbRCHAon>; Wed, 7 Mar 2001 19:44:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45065 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131241AbRCHAo3>; Wed, 7 Mar 2001 19:44:29 -0500
Subject: Re: Can't compile 2.4.2-ac14
To: amatsus@jaist.ac.jp (MATSUSHIMA Akihiro)
Date: Thu, 8 Mar 2001 00:47:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010308091307Z.amatsus@jaist.ac.jp> from "MATSUSHIMA Akihiro" at Mar 08, 2001 09:13:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aoac-00021Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> I receive the following error with make bzImage:
> 
> i386_ksyms.c:170: `do_BUG' undeclared here (not in a function)
> i386_ksyms.c:170: initializer element is not constant
> i386_ksyms.c:170: (near initialization for `__ksymtab_do_BUG.value')
> make[1]: *** [i386_ksyms.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.2-ac14/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2

Change it to

#ifdef CONFIG_DEBUG_BUGVERBOSE
EXPORT_SYMBOL(do_BUG);
#endif

sorry

