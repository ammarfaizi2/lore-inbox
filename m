Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVGFQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVGFQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVGFQX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:23:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64157 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262223AbVGFMIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:08:50 -0400
Date: Wed, 6 Jul 2005 14:08:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT and mptfusion
Message-ID: <20050706120848.GB16843@elte.hu>
References: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> The problem I have didn't exist in 48-36 : The last version I can run.
> >From the 50-47, ( I didn't test 40-38 through 50-46 ) I get the
> following problem : I cannot boot :

> with a 2.6.12 with RT patch and PREEMPT_RT
> ...
> Fusion MPT base driver 3.01.20
> Copyright (c) 1999-2004 LSI Logic Corporation
> ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 32 (level, low) -> IRQ 177
> mptbase: Initiating ioc0 bringup
> ioc0: 53C1030: Capabilities={Initiator}
> <== wait ~ 13 secondes
> ioc0: 53C1030: Initiating ioc0 recovery    <== New with the RT patch

which -RT kernel was the last you tried, 50-47? Could you send me your 
.config? It seems you have CONFIG_X86_UP_IOAPIC and CONFIG_PCI_MSI 
enabled - could you try -51-02 and both of these options disabled?

	Ingo
