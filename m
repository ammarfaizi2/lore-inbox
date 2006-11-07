Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753404AbWKGVgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbWKGVgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbWKGVgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:36:16 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:39246 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753400AbWKGVgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:36:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=egWqKNSQcZLoLYASAb3p7aiXzVfJb7Leoev9wZH3ojS4vmrxKYD8BGf5+gXI6qDBTq7BgVDZfvo5jLX9jwFaTxXmWXsKt/FYRODUa+GfBmIlwKeS5YdImPcpXaOj9kNkjPGbihJoE7nitNvIMWzOgDgU4LdmLnrORaDs4ER8QDY=  ;
Date: Tue, 07 Nov 2006 13:36:04 -0800
From: David Brownell <david-b@pacbell.net>
To: hskinnemoen@atmel.com, akpm@osdl.org
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Cc: linux-kernel@vger.kernel.org, andrew@sanpeople.com
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
 <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061107213604.692421DC800@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define EXTERNAL_IRQ_BASE	NR_INTERNAL_IRQS
> +#define NR_EXTERNAL_IRQS	32
> +#define GPIO_IRQ_BASE		(EXTERNAL_IRQ_BASE + NR_EXTERNAL_IRQS)
> +#define NR_GPIO_IRQS		(4 * 32)
> +
> +#define NR_IRQS			(GPIO_IRQ_BASE + NR_GPIO_IRQS)

Did I miss something, or are the IRQs starting at GPIO_IRQ_BASE
not actually implemented?  There's no irq_chip with name "GPIO"
or anything.  The AT91 code should be almost a drop-in there...

- Dave

