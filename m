Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSKJOQN>; Sun, 10 Nov 2002 09:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264880AbSKJOQM>; Sun, 10 Nov 2002 09:16:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27808 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264877AbSKJOQL>; Sun, 10 Nov 2002 09:16:11 -0500
Subject: BOGUS: megaraid changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>, matt_domsch@dell.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211070603.gA763cX03676@hera.kernel.org>
References: <200211070603.gA763cX03676@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 14:47:07 +0000
Message-Id: <1036939627.1099.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus - will you please stop merging plain dangerous "lets pretend we
never have errors" patches. I've got proper fixes for megaraid to use
the new_eh if you want them, but merging stuff so that people don't even
notice the problem is *WRONG*

Alan


On Wed, 2002-10-30 at 19:11, Linux Kernel Mailing List wrote:
> ChangeSet 1.844.14.2, 2002/10/30 13:11:37-06:00, Matt_Domsch@dell.com
> 
> 	megaraid: cleanups so it builds again
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.844.14.1 -> 1.844.14.2
> #	drivers/scsi/megaraid.c	1.25    -> 1.26   
> #	drivers/scsi/megaraid.h	1.11    -> 1.12   
> #
> 
>  megaraid.c |    1 -
>  megaraid.h |    2 --
>  2 files changed, 3 deletions(-)
> 
> 
> diff -Nru a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
> --- a/drivers/scsi/megaraid.c	Wed Nov  6 22:03:41 2002
> +++ b/drivers/scsi/megaraid.c	Wed Nov  6 22:03:41 2002
> @@ -4123,7 +4123,6 @@
>  	struct partition *p, *largest = NULL;
>  	int i, largest_cyl;
>  	int heads, cyls, sectors;
> -	int capacity = capacity;
>  	unsigned char *buf;
>  
>  	if (!(buf = scsi_bios_ptable(bdev)))
> diff -Nru a/drivers/scsi/megaraid.h b/drivers/scsi/megaraid.h
> --- a/drivers/scsi/megaraid.h	Wed Nov  6 22:03:41 2002
> +++ b/drivers/scsi/megaraid.h	Wed Nov  6 22:03:41 2002
> @@ -214,8 +214,6 @@
>      info:	     	megaraid_info,	   	/* Driver Info Function		*/\
>      command:	  	megaraid_command,	/* Command Function		*/\
>      queuecommand:  	megaraid_queue,		/* Queue Command Function	*/\
> -    abort:	    	megaraid_abort,	  	/* Abort Command Function	*/\
> -    reset:	    	megaraid_reset,	  	/* Reset Command Function	*/\
>      bios_param:     	megaraid_biosparam, 	/* Disk BIOS Parameters		*/\
>      can_queue:		MAX_COMMANDS,	    	/* Can Queue			*/\
>      this_id:	  	7,		       	/* HBA Target ID		*/\
> -
> To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

