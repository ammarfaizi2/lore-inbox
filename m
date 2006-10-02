Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbWJBS2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbWJBS2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbWJBS2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:28:50 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:7902 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S965276AbWJBS2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:28:49 -0400
Date: Mon, 2 Oct 2006 12:28:47 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move tg3 to pci_request_irq
Message-ID: <20061002182847.GN16272@parisc-linux.org>
References: <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002201134.GE3003@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002201134.GE3003@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 08:11:34PM +0000, Frederik Deweerdt wrote:
> @@ -6838,9 +6838,9 @@ restart_timer:
>  
>  static int tg3_request_irq(struct tg3 *tp)
>  {
> +	struct net_device *dev = tp->dev;
>  	irqreturn_t (*fn)(int, void *, struct pt_regs *);
>  	unsigned long flags;
> -	struct net_device *dev = tp->dev;
>  
>  	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
>  		fn = tg3_msi;

Is there any reason for this noise?

