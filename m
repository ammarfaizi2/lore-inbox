Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVFMMho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVFMMho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVFMMho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:37:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:30080 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261541AbVFMMhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:37:41 -0400
Date: Mon, 13 Jun 2005 14:37:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: cutaway@bellsouth.net
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Observations on x86 process.c
In-Reply-To: <002301c57018$266079b0$2800000a@pc365dualp2>
Message-ID: <Pine.LNX.4.61.0506131436180.1658@yvahk01.tjqt.qr>
References: <002301c57018$266079b0$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>A) dump_thread() and dump_task_regs() are in the middle of the file, but
>will be infrequently used. With default 16 byte alignment, this may cause
>bits of them to wind up polluting the L1 on anything with L1 lines > 16
>bytes.  L2 lines could be similarly polluted too of course.

C compilers are free to reorder functions (are they?), especially GCC when it 
is passed -funit-at-a-time (which currently is not in CFLAGS).



Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
