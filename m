Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVLKK7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVLKK7d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 05:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVLKK7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 05:59:33 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:18107 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751339AbVLKK7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 05:59:32 -0500
Date: Sun, 11 Dec 2005 11:58:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Gaurav Dhiman <gaurav4lkg@gmail.com>, yen <yen@eos.cs.nthu.edu.tw>,
       linux-kernel@vger.kernel.org
Subject: Re: IRQ vector assignment for system call exception
Message-ID: <20051211105844.GA4085@elte.hu>
References: <20051208080435.M54890@eos.cs.nthu.edu.tw> <1e33f5710512100520k57c016b0tadfbb496cac3ea6e@mail.gmail.com> <1134238271.2828.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134238271.2828.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Sat, 2005-12-10 at 18:50 +0530, Gaurav Dhiman wrote:
> > yes, definetely a historical reason. System libraries need to know
> > this vector to invoke system call.
> 
> nowadays it's also mostly unused; sysenter and friends are used 
> instead and they don't use this entry point.

note that some system-calls are still invoked via int80 by glibc, such 
as fork() - even on sysenter/syscall capable CPUs.

	Ingo
