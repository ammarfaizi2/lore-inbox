Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVDVHyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVDVHyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVDVHyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:54:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16835 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261360AbVDVHyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:54:17 -0400
Subject: Re: [TG3]: Add msi test
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200504220501.j3M51lkG012997@hera.kernel.org>
References: <200504220501.j3M51lkG012997@hera.kernel.org>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 09:54:12 +0200
Message-Id: <1114156452.6685.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Thu, 2005-04-21 at 22:01 -0700, Linux Kernel Mailing List wrote:
> tree 1e1c24ad874db00f827fc6d9087402db6becefc9
> parent 88b06bc26b87cf0490b0e3faea7fefc7549dd75d
> author Michael Chan <mchan@broadcom.com> Fri, 22 Apr 2005 07:13:59 -0700
> committer David S. Miller <davem@sunset.davemloft.net> Fri, 22 Apr 2005 07:13:59 -0700
> 
> [TG3]: Add msi test
> 
> Add MSI test for chips that support MSI. If MSI test fails, it will
> switch back to INTx mode and will print a message asking the user to
> report the failure.

While the technicals of this change are ok, this still concerns me. Are
all MSI drivers now supposed to check if the bios/mobo actually support
MSI like this? That sounds sort of wrong! 

