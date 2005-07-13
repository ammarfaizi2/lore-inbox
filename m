Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVGMJ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVGMJ7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 05:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVGMJ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 05:59:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43713 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261427AbVGMJ7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 05:59:14 -0400
Date: Wed, 13 Jul 2005 11:59:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christian Boehme <Christian.Boehme@gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at objrmap:325 in 2.6.5-7.151-smp (SuSE, x86_64)
In-Reply-To: <42D4D9BB.7010701@gwdg.de>
Message-ID: <Pine.LNX.4.61.0507131155080.14635@yvahk01.tjqt.qr>
References: <42D4D9BB.7010701@gwdg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We often see the following kernel-bug in our logs:

> kernel: Process mhd3d.opteron (pid: 4752, threadinfo 00000103e68d4000,
> kernel: task 00000101fb6e8c40)
> kernel: Stack: 0000000000000246 ffffffff801740db 00000103e5028800
> kernel: 0000010231caf010
> kernel: 0000000100000000 00000101fb0d9d90 00000103ea3b01e0
> kernel: 0000000000000000
> kernel: 000000000043c300 00000103f0947800
> kernel: Call Trace:<ffffffff801740db>{do_no_page+2987}
> kernel: <ffffffff801758a5>{handle_mm_fault+405}
> kernel: <ffffffff80122554>{do_page_fault+468}
> kernel: <ffffffff801477c1>{sys_rt_sigaction+113}
> kernel: <ffffffff80111041>{error_exit+0}

SUSE kontaktieren (bugzilla.novell.com) (oder auch bei Eberhard nachfragen). 
Aber da wirst du wahrscheinlich auch nicht viel erfahren, da der Stack Trace 
nicht viel enthaelt.

Ich gehe mal davon aus, dass die Userspace-Anwendung, die das verursacht, 'n 
Segfault erhaelt. Du kannst also mal 'n strace mitlaufen lassen und schauen, 
welcher "Userspace-Syscall" das ausloest. Eigentlich steht's auch da: 
rt_sigaction() [man rt_sigaction] aber da ist auch nicht viel bei.

Was ist ueberhaupt mhd3d.opteron? Und sonst, halt einfach mal auf neueres SUSE 
updaten, die haben naemlich schon in kurzer Zeit den Sprung von 2.6.5 auf 
2.6.8 auf 2.6.11 gemacht - zumindest im KOTD.

> Interestingly
> after this bug the /proc/4751 dir (i.e., the one of the instance
> not cited in the bug) is inaccessible. Thanks for any help
> with this issue!

Welche Fehlernummer? Mal mit root probiert, reinzukommen?



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/

