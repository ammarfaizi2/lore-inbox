Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVIBRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVIBRzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVIBRzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:55:04 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:38948 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbVIBRzC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:55:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zr9uQXurW9obj04B48EAbbpbSuWEK8oYPDpaDmo4gqYknsOInEVi4m28yH58pUnCPjK65APKkYSUHwf4a5Gahf/GUBup2J1LtownQ00Mo4n9kwDEFzvDZ09Zxt3HCVnKGd3DKRM1gKrGFhAxQDS8t0puaYkb/8FI2tEnaztCeMg=
Message-ID: <2c0942db05090210556ad0a7d@mail.gmail.com>
Date: Fri, 2 Sep 2005 10:55:00 -0700
From: Ray Lee <madrabbit@gmail.com>
Reply-To: ray@madrabbit.org
To: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20050901222617.2455520F96@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com>
	 <4314C604.4030208@pobox.com>
	 <20050901142754.B93BF27137@lns1058.lss.emc.com>
	 <20050901144038.GA25830@infradead.org>
	 <20050901222617.2455520F96@lns1058.lss.emc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Brett Russ <russb@emc.com> wrote:
> More (non-functional) style modifications since the version 0.11
> driver I sent out earlier today.  Removed most parens around return
> value, 

return is not a function call; you can safely remove them all.

> +       return ((void __iomem *)((unsigned long)port_mmio &
> +                                (unsigned long)SATAHC_MASK));
> +       return (base + MV_SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));
> +       return (mv_hc_base(base, port >> MV_PORT_HC_SHIFT) +
> +               MV_SATAHC_ARBTR_REG_SZ +
> +               ((port & MV_PORT_MASK) * MV_PORT_REG_SZ));
> +       return ((flags & MV_FLAG_DUAL_HC) ? 2 : 1);
> +       return (EDMA_EN & readl(port_mmio + EDMA_CMD_OFS));
> +       return (ap->flags & MV_FLAG_BDMA);

Ray
