Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292195AbSBTTBG>; Wed, 20 Feb 2002 14:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292211AbSBTTA5>; Wed, 20 Feb 2002 14:00:57 -0500
Received: from msg.vizzavi.pt ([212.18.167.162]:3294 "EHLO msg.vizzavi.pt")
	by vger.kernel.org with ESMTP id <S292195AbSBTTAt>;
	Wed, 20 Feb 2002 14:00:49 -0500
Date: Wed, 20 Feb 2002 19:10:39 +0000
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in _every_ 2.5 kernel - SCSI changes
Message-ID: <20020220191039.A284@bleach>
In-Reply-To: <20020220005811.C488@bleach> <20020220111055.GC705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020220111055.GC705@suse.de>; from axboe@suse.de on Wed, Feb 20, 2002 at 11:10:55 +0000
X-Mailer: Balsa 1.3.0
X-OriginalArrivalTime: 20 Feb 2002 19:00:43.0971 (UTC) FILETIME=[E5D52930:01C1BA40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 2002.02.20 11:10 Jens Axboe wrote:

> Hmm, does this work? What SCSI devices do you have attached?
> 
> --- drivers/scsi/scsi_merge.c~	Wed Feb 20 12:08:11 2002
> +++ drivers/scsi/scsi_merge.c	Wed Feb 20 12:07:26 2002
> @@ -136,7 +136,7 @@
>   			 * hardware have no practical limit.
>  			 */
>  			bounce_limit = BLK_BOUNCE_ANY;
> -		else
> +		else if (SHpnt->pci_dev)
>  			bounce_limit = SHpnt->pci_dev->dma_mask;
>  	} else if (SHpnt->unchecked_isa_dma)
>  		bounce_limit = BLK_BOUNCE_ISA;
> 


It sure does! My days of seeking for this trivial fix are now over, 
phew 8)
Thanks a lot Jens, keep up the great work.

// Paulo Andre'
