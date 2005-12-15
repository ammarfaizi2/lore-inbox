Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVLOXRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVLOXRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVLOXRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:17:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13232 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751182AbVLOXRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:17:08 -0500
Subject: Re: IRQ vector assignment for system call exception
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ingo Molnar <mingo@elte.hu>, Gaurav Dhiman <gaurav4lkg@gmail.com>,
       yen <yen@eos.cs.nthu.edu.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512152349580.13568@yvahk01.tjqt.qr>
References: <20051208080435.M54890@eos.cs.nthu.edu.tw>
	 <1e33f5710512100520k57c016b0tadfbb496cac3ea6e@mail.gmail.com>
	 <1134238271.2828.19.camel@laptopd505.fenrus.org>
	 <20051211105844.GA4085@elte.hu>
	 <Pine.LNX.4.61.0512152349580.13568@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 00:16:57 +0100
Message-Id: <1134688617.2992.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 23:50 +0100, Jan Engelhardt wrote:
> >> On Sat, 2005-12-10 at 18:50 +0530, Gaurav Dhiman wrote:
> >> > yes, definetely a historical reason. System libraries need to know
> >> > this vector to invoke system call.
> >> 
> >> nowadays it's also mostly unused; sysenter and friends are used 
> >> instead and they don't use this entry point.
> >
> >note that some system-calls are still invoked via int80 by glibc, such 
> >as fork() - even on sysenter/syscall capable CPUs.
> 
> OT: Any idea when glibc moves to use sysenter on capable CPUs?

it has been doing that for a LOOOONG time
exception are syscalls that sysenter can't do (iirc 6 argument ones, and
I suspect fork() because it's just "special", but all normal ones are
done via sysenter already from even before 2.6.0 got released.


