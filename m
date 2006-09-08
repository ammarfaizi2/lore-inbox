Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWIHV2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWIHV2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIHV2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:28:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:206 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751163AbWIHV2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:28:19 -0400
Subject: Re: [PATCH -rt] use SA_NODELAY for XScale PMU interrupts
From: Arjan van de Ven <arjan@infradead.org>
To: Kevin Hilman <khilman@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4501C2FE.40109@mvista.com>
References: <4501C2FE.40109@mvista.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 08 Sep 2006 23:27:49 +0200
Message-Id: <1157750869.30730.137.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 12:22 -0700, Kevin Hilman wrote:
> In the XScale oprofile support, the performance monitoring unit (PMU)
> triggers interrupts and the ISR reads out the performance data.  These
> ISRs are currently set to SA_INTERRUPT.  In order to get accurate
> performance and profiling data under PREEMPT_RT, these should use
> SA_NODELAY.  The functions called by this ISR are limited to
> drivers/oprofile functions.
> 
> Patch against 2.6.18-rt8


hmm I thought the SA_ flags were deprecated ???


