Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVJEK0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVJEK0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVJEK0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:26:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50339 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932256AbVJEK0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:26:20 -0400
Subject: Re: Using DMA in read/write, setting block size for I/O ->
	max_sectors
From: Arjan van de Ven <arjan@infradead.org>
To: Karthik Sarangan <karthiks@cdac.in>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4343A046.1090605@cdac.in>
References: <434288E9.3090108@cdac.in>
	 <1128436401.2922.11.camel@laptopd505.fenrus.org> <43437163.1020201@cdac.in>
	 <1128500135.2920.11.camel@laptopd505.fenrus.org> <4343A046.1090605@cdac.in>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 12:26:05 +0200
Message-Id: <1128507966.2920.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 15:13 +0530, Karthik Sarangan wrote:
> Arjan van de Ven wrote:
> 
> >max_sectors in the host template for scsi
> 
> Can I set this parameter during startup for scsi_mod.ko during load?

no it's a property of the hardware and as such the DRIVER has to set it.
Not all hw can deal with really big sizes, so the driver is supposed to
set what the hw is capable of.

> I actually needed a 256KB transfer size 

needed in what sense? 2x 128Kb isn't too bad either anyway :)


