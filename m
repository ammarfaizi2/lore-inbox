Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVFXPMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVFXPMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVFXPMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:12:46 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:22963 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262920AbVFXPMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:12:40 -0400
Message-ID: <42BC2501.5090101@ru.mvista.com>
Date: Fri, 24 Jun 2005 19:21:37 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: akpm@osdl.org, linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org, yshpilevsky@ru.mvista.com
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
References: <42BAD78E.1020801@ru.mvista.com> <20050623140522.GA25724@logos.cnet>
In-Reply-To: <20050623140522.GA25724@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Marcelo Tosatti wrote:
> Hi Andrei,
> 
> On Thu, Jun 23, 2005 at 07:38:54PM +0400, Andrei Konovalov wrote:
> <snip>
> 
>>diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
>>--- a/arch/ppc/syslib/m8xx_setup.c
>>+++ b/arch/ppc/syslib/m8xx_setup.c
>>@@ -369,7 +369,7 @@ m8xx_map_io(void)
>> #if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
>> 	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
>> #endif
>>-#ifdef CONFIG_FADS
>>+#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
>> 	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
>> #endif
>> #ifdef CONFIG_PCI
> 
> 
> I suppose you also want to include CONFIG_MPC885ADS in the io_block_mapping(IO_BASE) 
> here?

No, not at the moment at least.
Actually, the patch doesn't even #define IO_BASE.
In 2.4 that io_block_mapping(IO_BASE) was needed for PCMCIA / CF cards to work.
We haven't got to PCMCIA support in 2.6 yet, and PCMCIA is unlikely to work
as is in case of MPC885ADS, as drivers/pcmcia/m8xx_pcmcia.c is just missing.
We plan to address PCMCIA later.


Thanks,
Andrei

