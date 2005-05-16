Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVEPIkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVEPIkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVEPIem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:34:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37286 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261416AbVEPIGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 04:06:20 -0400
Subject: Re: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
From: Arjan van de Ven <arjan@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCE7C@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE7C@exa-atlanta>
Content-Type: text/plain
Date: Mon, 16 May 2005 10:06:16 +0200
Message-Id: <1116230776.6274.20.camel@laptopd505.fenrus.org>
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

> +
> +		if (exception) {
> +	
> +			spin_lock( instance->host_lock );
> +			cmd->scmd->scsi_done( cmd->scmd );
> +			spin_unlock( instance->host_lock );

are you really sure you don't want to use spin_lock_irqsave() here ?

> +	unregister_chrdev( megasas_mgmt_majorno, "megaraid_sas_ioctl" );

I really don't like this idea of weird ioctl devices though...


