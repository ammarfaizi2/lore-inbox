Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVLGRFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVLGRFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVLGRFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:05:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39644 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751092AbVLGRFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:05:22 -0500
Subject: Re: Missing break in timedia serial setup.
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051207165811.GA3574@redhat.com>
References: <20051207010526.GA7258@redhat.com>
	 <20051207093431.GB32365@flint.arm.linux.org.uk>
	 <20051207165811.GA3574@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 18:05:19 +0100
Message-Id: <1133975119.2869.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.14/drivers/serial/8250_pci.c~	2005-12-07 11:56:13.000000000 -0500
> +++ linux-2.6.14/drivers/serial/8250_pci.c	2005-12-07 11:56:41.000000000 -0500
> @@ -516,7 +516,6 @@ pci_timedia_setup(struct serial_private 
>  		break;
>  	case 3:
>  		offset = board->uart_offset;
> -		bar = 1;
>  	case 4: /* BAR 2 */
>  	case 5: /* BAR 3 */
>  	case 6: /* BAR 4 */
> -

might as well add a /* fall through */ comment
so that this doesn't come up again in the future..


