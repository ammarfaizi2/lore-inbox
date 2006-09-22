Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWIVCDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWIVCDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWIVCDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:03:24 -0400
Received: from main.gmane.org ([80.91.229.2]:20676 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932200AbWIVCDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:03:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Date: Fri, 22 Sep 2006 04:03:17 +0200
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <45134465.8060703@flower.upol.cz>
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Luke Yang <luke.adi@gmail.com>
X-Gmane-NNTP-Posting-Host: 158.194.180.30
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
X-Image-Url: http://flower.upol.cz/~olecom/upol-cz.png
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Luke Yang, who wrote:
> +static void bfin_serial_mctrl_check(struct bfin_serial_port *uart);
> +
> +/*
> + * interrupts disabled on entry
> + */

spelling error: _are_ disabled
please grep && sed all patches

> +static void bfin_serial_stop_tx(struct uart_port *port)
> +{
> +    struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
> +    unsigned short ier;
> +    ier = UART_GET_IER(uart);
> +    ier &= ~ETBEI;
> +    UART_PUT_IER(uart, ier);
> +#ifdef CONFIG_SERIAL_BFIN_DMA
> +    disable_dma(uart->tx_dma_channel);
> +#endif
> +}

one blank line after local variables; you are using this in some functions, in 
some you are not...

> +
> +static void bfin_serial_shutdown(struct uart_port *port)
> +{
> +    struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
> +

yes, one more space will be nicer

> +    free_irq(uart->port.irq+1, uart);

here and the like


-- 
-o--=O`C
  #oo'L O  5 years ago TT and WTC7 were assassinated
<___=E M  learn more how (tm) <http://911research.com>

