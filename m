Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVB1RQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVB1RQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVB1RPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:15:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:21654 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261697AbVB1RPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:15:17 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: tglx@linutronix.de
Subject: Re: [PATCH 10/10] IA64:  C99 initializers for hw_interrupt_type structures
Date: Mon, 28 Feb 2005 09:14:51 -0800
User-Agent: KMail/1.7.2
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org
References: <20050227005956.1.patchmail@tglx> <20050227010029.10.patchmail@tglx>
In-Reply-To: <20050227010029.10.patchmail@tglx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502280914.51629.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  struct hw_interrupt_type irq_type_sn = {
> - "SN hub",
> - sn_startup_irq,
> - sn_shutdown_irq,
> - sn_enable_irq,
> - sn_disable_irq,
> - sn_ack_irq,
> - sn_end_irq,
> - sn_set_affinity_irq
> + .typename = "SN hub",
> + .startup = sn_startup_irq,
> + .shutdown = sn_shutdown_irq,
> + .enable = sn_enable_irq,
> + .disable = sn_disable_irq,
> + .ack = sn_ack_irq,
> + .end = sn_end_irq,
> + .set_affinity = sn_set_affinity_irq
>  };
>
>  unsigned int sn_local_vector_to_irq(u8 vector)

Looks fine.

Acked-by: Jesse Barnes <jbarnes@sgi.com>
