Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbSJQUFE>; Thu, 17 Oct 2002 16:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbSJQUFE>; Thu, 17 Oct 2002 16:05:04 -0400
Received: from h-66-167-76-31.SNVACAID.covad.net ([66.167.76.31]:25474 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261805AbSJQUFC>; Thu, 17 Oct 2002 16:05:02 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 17 Oct 2002 13:10:56 -0700
Message-Id: <200210172010.NAA01600@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.43: "fix old protocol handler pppoe_rcv+0x0/0x124 [pppoe]"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	In linux-2.5.42 and .43, I get this recurring error message:

fix old protocol handler pppoe_rcv+0x0/0x124 [pppoe]

	which is apparently from deliver_to_old_ones() in net/core/dev.c:

#if CONFIG_SMP
        /* Old protocols did not depened on BHs different of NET_BH and
           TIMER_BH - they need to be fixed for the new assumptions.
         */
        print_symbol("fix old protocol handler %s!\n", (unsigned long)pt->func)\
;
#endif

	I'm puzzling out exactly change this message is requesting,
and I thought it might be a better use of everyone's time if I first
ask if there is a porting guide or other document about converting an
"old" style protocol handler to a "new" one.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
