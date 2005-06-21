Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVFUUnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVFUUnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVFUUml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:42:41 -0400
Received: from unused.mind.net ([69.9.134.98]:7855 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261424AbVFUUk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:40:27 -0400
Date: Tue, 21 Jun 2005 13:37:35 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050621201742.GA16400@kvack.org>
Message-ID: <Pine.LNX.4.58.0506211332080.17025@echo.lysdexia.org>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com>
 <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com>
 <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
 <20050621131009.GA22691@elte.hu> <20050621201742.GA16400@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Benjamin LaHaise wrote:

> On Tue, Jun 21, 2005 at 03:10:09PM +0200, Ingo Molnar wrote:
> > find the patch below - it's also included in the -50-05 -RT tree i just 
> > uploaded. Can you confirm that you dont get the warnings in the -50-05 
> > (and later) -RT kernels?
> 
> Looks good.  Acked-by: Benjamin LaHaise <bcrl@kvack.org>
> 
> 		-ben

-50-06 locked up shortly after starting:

	dd if=/dev/urandom of=/dev/null bs=8192

No bug warnings on the ns83820, but I did get these messages (last thing 
that made it syslog):

Jun 21 12:29:37 manzanita kernel: eth0: tx_timeout: tx_done_idx=90 free_idx=95 cmdsts=08000068
Jun 21 12:29:37 manzanita kernel: eth0: after: tx_done_idx=95 free_idx=95 cmdsts=00000000
Jun 21 12:29:51 manzanita kernel: eth0: tx_timeout: tx_done_idx=126 free_idx=3 cmdsts=080000ea
Jun 21 12:29:51 manzanita kernel: eth0: after: tx_done_idx=3 free_idx=3 cmdsts=00000000
Jun 21 12:30:11 manzanita kernel: eth0: tx_timeout: tx_done_idx=17 free_idx=19 cmdsts=08000042
Jun 21 12:30:11 manzanita kernel: eth0: after: tx_done_idx=19 free_idx=19 cmdsts=00000000

Anything to worry about?

--ww
