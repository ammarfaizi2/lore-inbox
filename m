Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSJ0Npk>; Sun, 27 Oct 2002 08:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJ0Npk>; Sun, 27 Oct 2002 08:45:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1742 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262394AbSJ0Npk>; Sun, 27 Oct 2002 08:45:40 -0500
Subject: Re: [BUG]Kernel Panic while booting 2.5.44
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Tscharner <starfire@dplanet.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20021027143305.42aa7463.starfire@dplanet.ch>
References: <20021027143305.42aa7463.starfire@dplanet.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Oct 2002 14:10:13 +0000
Message-Id: <1035727813.30551.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-27 at 13:33, Andreas Tscharner wrote:
> Hello World,
> 
> I got a Kernel Panic when I try to boot 2.5.44. Bug output and
> configuration below. GCC version 2.95.4
> 
> 
> kernel BUG at kernel/workqueue.c:69!
> invalid operand: 0000

Does this help ?

--- drivers/scsi/ppa.c~	2002-10-27 14:05:37.000000000 +0000
+++ drivers/scsi/ppa.c	2002-10-27 14:05:37.000000000 +0000
@@ -201,6 +201,8 @@
 	default:		/* Never gets here */
 	    continue;
 	}
+	
+	INIT_WORK(&ppa_hosts[i].ppa_tq, ppa_interrupt, &ppa_hosts[i]);
 
 	host->can_queue = PPA_CAN_QUEUE;
 	host->sg_tablesize = ppa_sg;
