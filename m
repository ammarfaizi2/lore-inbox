Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWAFTy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWAFTy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWAFTy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:54:57 -0500
Received: from emulex.emulex.com ([138.239.112.1]:19074 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S964833AbWAFTy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:54:56 -0500
Message-ID: <43BEC945.6030905@emulex.com>
Date: Fri, 06 Jan 2006 14:47:17 -0500
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/lpfc/lpfc_scsi.c: make lpfc_get_scsi_buf()
 static
References: <20060106192128.GC12131@stusta.de>
In-Reply-To: <20060106192128.GC12131@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2006 19:47:17.0561 (UTC) FILETIME=[FFDF2A90:01C612F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK - fine :)

-- james

Adrian Bunk wrote:
> This patch makes the needlessly global function lpfc_sli_get_scsi_buf()
> static.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-mm1-full/drivers/scsi/lpfc/lpfc_scsi.c.old	2006-01-06 19:50:38.000000000 +0100
> +++ linux-2.6.15-mm1-full/drivers/scsi/lpfc/lpfc_scsi.c	2006-01-06 19:50:46.000000000 +0100
> @@ -150,7 +150,7 @@
>  	return psb;
>  }
>  
> -struct  lpfc_scsi_buf*
> +static struct lpfc_scsi_buf*
>  lpfc_get_scsi_buf(struct lpfc_hba * phba)
>  {
>  	struct  lpfc_scsi_buf * lpfc_cmd = NULL;
> 
> 
