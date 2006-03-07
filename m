Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWCGX7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWCGX7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWCGX7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:59:46 -0500
Received: from mms1.broadcom.com ([216.31.210.17]:57356 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1751687AbWCGX7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:59:45 -0500
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Subject: Re: [TG3]: Add DMA address workaround
From: "Michael Chan" <mchan@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       "Anton Blanchard" <anton@samba.org>,
       "Paul Mackerras" <paulus@samba.org>
In-Reply-To: <1141773668.11221.110.camel@localhost.localdomain>
References: <200603071900.k27J0YSP023014@hera.kernel.org>
 <1141773668.11221.110.camel@localhost.localdomain>
Date: Tue, 07 Mar 2006 14:18:58 -0800
Message-ID: <1141769938.8146.19.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006030708; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230342E34343045314534382E303035332D412D;
 ENG=IBF; TS=20060308000105; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006030708_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6810C13436K5611103-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 10:21 +1100, Benjamin Herrenschmidt wrote:

> 
> I suppose that means I need to update the ppc64 iommu code to actually
> honor the DMA mask when allocating ;) That will be easy for "dumb"
> iommu's like the G5 but might be a bit more tricky with pSeries.
> 
> Anton, Paul, we have no control on the DMA ranges allocated to each phb
> in the system, do we know if they go beyond 32 bits ? (And if yes,
> beyond 40 bits)
> 
So how does powerpc handle 32-bit PCI devices that don't support dual
address cycles? Such devices will set the dma_mask to 32-bit. Shouldn't
40-bit be handled in a similar way?

