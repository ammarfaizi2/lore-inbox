Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291759AbSBTLTo>; Wed, 20 Feb 2002 06:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291762AbSBTLTe>; Wed, 20 Feb 2002 06:19:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44549 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291759AbSBTLT1>;
	Wed, 20 Feb 2002 06:19:27 -0500
Date: Wed, 20 Feb 2002 12:10:55 +0100
From: Jens Axboe <axboe@suse.de>
To: "Paulo Andre'" <l16083@alunos.uevora.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in _every_ 2.5 kernel - SCSI changes
Message-ID: <20020220111055.GC705@suse.de>
In-Reply-To: <20020220005811.C488@bleach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020220005811.C488@bleach>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20 2002, Paulo Andre' wrote:
> Hi Jens,
> 
> This is a very keen and motivated kernel hacker newbie here. That said, 
> bear with me :)

Hmm, does this work? What SCSI devices do you have attached?

--- drivers/scsi/scsi_merge.c~	Wed Feb 20 12:08:11 2002
+++ drivers/scsi/scsi_merge.c	Wed Feb 20 12:07:26 2002
@@ -136,7 +136,7 @@
  			 * hardware have no practical limit.
 			 */
 			bounce_limit = BLK_BOUNCE_ANY;
-		else
+		else if (SHpnt->pci_dev)
 			bounce_limit = SHpnt->pci_dev->dma_mask;
 	} else if (SHpnt->unchecked_isa_dma)
 		bounce_limit = BLK_BOUNCE_ISA;

-- 
Jens Axboe

