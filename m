Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWFSVlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWFSVlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWFSVlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:41:18 -0400
Received: from main.gmane.org ([80.91.229.2]:33699 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964905AbWFSVlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:41:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marcus Furlong <furlongm@hotmail.com>
Subject: Re: PATA driver patch for 2.6.17
Date: Mon, 19 Jun 2006 22:40:57 +0100
Message-ID: <e775l9$91l$1@sea.gmane.org>
References: <1150740947.2871.42.camel@localhost.localdomain> <e76uv1$g1s$1@sea.gmane.org> <1150751279.2871.46.camel@localhost.localdomain>
Reply-To: furlongm@hotmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83-70-234-22.b-ras1.prp.dublin.eircom.net
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Ar Llu, 2006-06-19 am 20:46 +0100, ysgrifennodd Marcus Furlong:
>> Alan Cox wrote:
>> 
>> > http://zeniv.linux.org.uk/~alan/IDE
>> > 
>> > This is basically a resync versus 2.6.17, the head of the PATA tree is
>> > now built against Jeffs tree with revised error handling and the like.
>> > 
>> > Alan
>> 
>> I get the following bug while booting:
> 
> Sorry about that. I messed up a patch segment in the merge
> 
> --- drivers/scsi/ata_piix.c~  2006-06-19 21:38:43.746144712 +0100
> +++ drivers/scsi/ata_piix.c   2006-06-19 21:38:43.747144560 +0100
> @@ -360,6 +360,8 @@
>  .qc_prep             = ata_qc_prep,
>  .qc_issue            = ata_qc_issue_prot,
>  
> +     .data_xfer              = ata_pio_data_xfer,
> +
>  .eng_timeout         = ata_eng_timeout,
>  
>  .irq_handler         = ata_interrupt,

That fixes it. Thanks! :)

