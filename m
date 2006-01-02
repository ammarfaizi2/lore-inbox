Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWABOO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWABOO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWABOO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:14:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31218 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750739AbWABOO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:14:58 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F36732330E@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F36732330E@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 06:14:55 -0800
Message-Id: <1136211295.22548.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 08:57 +0100, kus Kusche Klaus wrote:
>          
>   <idle>-0     0D...    1us+: preempt_schedule_irq (svc_preempt)
>   <idle>-0     0....    5us!: default_idle (cpu_idle)
>   <idle>-0     0D..1 8700us+: asm_do_IRQ (c021da48 1a 0)

Your trace appears to be showing an actual latency of 300us . The trace
starts at 8700us . The default_idle line above is showing interrupts are
enable, and preemption is enabled . So the tracing code really should be
ignoring the default_idle line since there is no reason to be tracing. 

Daniel

