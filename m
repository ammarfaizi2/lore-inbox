Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVEWNxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEWNxq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 09:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVEWNxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 09:53:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46828 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261629AbVEWNxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 09:53:43 -0400
Subject: Re: New revision of promise TX4
From: Arjan van de Ven <arjan@infradead.org>
To: Laurent CARON <lcaron@apartia.fr>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <4291DDA5.3070706@apartia.fr>
References: <4291DDA5.3070706@apartia.fr>
Content-Type: text/plain
Date: Mon, 23 May 2005 15:53:39 +0200
Message-Id: <1116856420.6280.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 15:41 +0200, Laurent CARON wrote:
> Hello,
> 
> I recently bought a TX-4 which seems to be using a new chip (PCI ID: 
> 105A:3519).
> 
> It was not supported by the kernel so i added those lines to promise_sata.c
> 
> diff sata_promise.c /usr/src/linux-2.6.11.9/drivers/scsi/sata_promise.c
> 170,171d169
> <       { PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> <         board_20319 },
> 
> 
> Is it the 'right' way?

if it works.. almost
the "right" way is to use "diff -purN" instead of just plain diff (it's
custom) and to do the files the other way around (again custom). 

If you want to make it nice you add a PCI_ID_... constant for 0x3519 to
the header and use the symbolic constant in your code instead.

Greetings,
   Arjan van de Ven

