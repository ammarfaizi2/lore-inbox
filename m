Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUEGAOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUEGAOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 20:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUEGAOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 20:14:17 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:47120 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S261752AbUEGAOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 20:14:15 -0400
Date: Thu, 6 May 2004 21:14:07 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Zhenmin Li <zli4@cs.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OPERA] Potential bugs detected by static analysis tool in 2.6.4
Message-ID: <20040507001407.GK9037@lorien.prodam>
Mail-Followup-To: Zhenmin Li <zli4@cs.uiuc.edu>,
	linux-kernel@vger.kernel.org
References: <002701c4331c$092a3b40$76f6ae80@Turandot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002701c4331c$092a3b40$76f6ae80@Turandot>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Zhenmin,

Em Wed, May 05, 2004 at 10:41:37PM -0500, Zhenmin Li escreveu:

| 9. /drivers/pci/hotplug/shpchp_ctrl.c, Line 1575:
| err("%s: Failed to disable slot, error code(%d)\n", __FUNCTION__, rc);
| 
| Maybe change to:
| err("%s: Failed to disable slot, error code(%d)\n", __FUNCTION__, retval);

 This seems right to me.

| 
| 10. /sound/oss/swarm_cs4297a.c, Line 2019:
| s->dma_adc.blocks = s->dma_dac.wakeup = 0;
| 
| Maybe change to:
| s->dma_adc.blocks = s->dma_adc.wakeup = 0;

 This don't. At a first look seems that 'dma_adc' and 'dma_dac' is the some
thing typed wrong, but don't, they are not the some thing.

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
