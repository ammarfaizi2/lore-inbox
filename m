Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVCIIGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVCIIGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 03:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVCIIGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 03:06:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2789 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261287AbVCIIGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 03:06:47 -0500
Subject: RE: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod
	ule  for LSI Logic's SAS based MegaRAID controllers
From: Arjan van de Ven <arjan@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CC18@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230CC18@exa-atlanta>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 09:06:38 +0100
Message-Id: <1110355598.6280.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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

On Tue, 2005-03-08 at 18:08 -0500, Bagalkote, Sreenivas wrote:
> 
> I will make this an instance parameter if the idea to reduce as many
> global variables as possible. But if the objection is because each
> adapter
> may have different value for variable, then it is indeed a global
> value.
> "is_dma64" - which is computed using the size of dma_addr_t - is
> telling
> something about the kernel rather than the controller feature.
> 

then having it as variable sounds really really wrong; the size of
dma_addr_t is a compile time property...
(and why do you care about it? you see high dma addresses when they come
in, right?)

