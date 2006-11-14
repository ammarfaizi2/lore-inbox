Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966203AbWKNQql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966203AbWKNQql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966202AbWKNQql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:46:41 -0500
Received: from rtr.ca ([64.26.128.89]:26632 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966203AbWKNQqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:46:40 -0500
Message-ID: <4559F2EE.7080309@rtr.ca>
Date: Tue, 14 Nov 2006 11:46:38 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>	 <1163363479.3423.8.camel@w100>  <45588132.9090200@rtr.ca> <1163479852.3340.9.camel@w100>
In-Reply-To: <1163479852.3340.9.camel@w100>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alberto Alonso wrote:
> Things are improving, after the latest patch I can still
> see spurious messages, but the count stays at 0.

Mmm.. Okay, so we have a kludge fix (just get rid of the printk's we added).

But I would like to find out more about what is going on.
We seem to be getting lots of "leftover interrupts".
I'll look through my full qstor block driver (the high-performance
queuing driver, out-of-tree), and see if we missed an IRQ-mask bit
someplace in the simple sata_qstor.c re-implementation.

Cheers
