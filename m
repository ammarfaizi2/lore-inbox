Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135183AbRDLNGf>; Thu, 12 Apr 2001 09:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135184AbRDLNG0>; Thu, 12 Apr 2001 09:06:26 -0400
Received: from iris.mc.com ([192.233.16.119]:4283 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S135183AbRDLNGF>;
	Thu, 12 Apr 2001 09:06:05 -0400
From: Mark Salisbury <mbs@mc.com>
To: linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer ! 
Date: Thu, 12 Apr 2001 08:58:16 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0104120859281P.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Apr 2001, Bret Indrelee wrote:
> Current generation PCs can easily handle 1000s of
> interrupts a second if you keep the overhead small.

the PC centric implementation of the ticked system is one of its major flaws.

there are architectures which the cost of a fixed interval is the same as a
variable interval, i.e. no reload register, so you must explicitely load a
value each interrupt anyway. and if you want accurate intervals, you must
perform a calculation each reload, and not just load a static value, because
you don't know how many cycles it took from the time the interrupt happened
till you get to the reload line because the int may have been masked or lower
pri than another interrupt.

also, why handle 1000's of interrupts if you only need to handle 10?

-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

