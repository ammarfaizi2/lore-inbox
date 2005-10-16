Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVJPRl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVJPRl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVJPRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 13:41:56 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:44953 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751332AbVJPRl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 13:41:56 -0400
Date: Sun, 16 Oct 2005 10:41:37 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510161741.j9GHfbY6020508@rastaban.cs.pdx.edu>
To: romieu@fr.zoreil.com
Cc: linux-kernel@vger.kernel.org
Subject: drivers/net/r8169 comment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the sourcecode in rtl8169_down()
of drivers/net/r8169.c and the comparable code in
sis190_down() of drivers/net/sis190_down()
supports removing that comment as you suggest here.

I'd used this comparison to resolve an RCU question,
so I'm not the person to address this.
Thank you for the clarification.

----- Original Message ----- 
From: "Francois Romieu" <romieu@fr.zoreil.com>
Sent: Saturday, October 15, 2005 4:24 AM
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio

>> synchronize_sched() is called in drivers/net/sis190.c and 
>> r8169.c with FIXME comment about synchronize_irq()
> 
> Same author for both. The code (driver specific) can be issued from
> userspace and it needs to wait for running hard_start_xmit to
> complete. Afaik synchronize_irq() is not adequate and the FIXME
> should go.
> 
> --
> Ueimor
>
