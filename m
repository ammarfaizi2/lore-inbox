Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270483AbRHNHjL>; Tue, 14 Aug 2001 03:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270485AbRHNHjB>; Tue, 14 Aug 2001 03:39:01 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:19180 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S270483AbRHNHir>;
	Tue, 14 Aug 2001 03:38:47 -0400
Message-ID: <XFMail.20010814093858.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 14 Aug 2001 09:38:58 +0200 (CEST)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: esssolo problems since 2.4.7 (and 2.4.8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

having problems since kernel version 2.4.7 and 2.4.8 to make a specific kernel
with support of esssolo sound card: 

...
make modules_install

...

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.8; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/drivers/sound/esssolo1.o
depmod:         gameport_register_port
depmod:         gameport_unregister_port


Applying AC's patches removes this problem.

My question: will this bug be fixed in 2.4.9 so that kernel 2.4.9 can be
installed correctly from the original source linux-2.4.9.tar.gz?
 
Regards

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

