Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVEPOZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVEPOZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEPOZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:25:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19630 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261662AbVEPOZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:25:02 -0400
Subject: Re: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
From: Arjan van de Ven <arjan@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
In-Reply-To: <1116253084.5040.1.camel@mulgrave>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE7C@exa-atlanta>
	 <1116230776.6274.20.camel@laptopd505.fenrus.org>
	 <1116253084.5040.1.camel@mulgrave>
Content-Type: text/plain
Date: Mon, 16 May 2005 16:24:56 +0200
Message-Id: <1116253496.6274.45.camel@laptopd505.fenrus.org>
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

On Mon, 2005-05-16 at 09:18 -0500, James Bottomley wrote:
> On Mon, 2005-05-16 at 10:06 +0200, Arjan van de Ven wrote:
> > > +			spin_lock( instance->host_lock );
> > > +			cmd->scmd->scsi_done( cmd->scmd );
> > > +			spin_unlock( instance->host_lock );
> > 
> > are you really sure you don't want to use spin_lock_irqsave() here ?
> 
> Actually, don't bother with the lock at all.  scsi_done() is designed to
> be called locklessly.

doh sorry I missed that (but knew it)
proves I need to drink the coffee BEFORE the patch review ;)


