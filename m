Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbTDAVMS>; Tue, 1 Apr 2003 16:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTDAVMS>; Tue, 1 Apr 2003 16:12:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35989 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262876AbTDAVMQ>; Tue, 1 Apr 2003 16:12:16 -0500
Date: Tue, 1 Apr 2003 16:26:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] PATCH: dpt_i2o memory leak comments
In-Reply-To: <20030401131504.5d25020b.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0304011624030.27457@chaos>
References: <200304012105.h31L5vG11354@hera.kernel.org>
 <20030401131504.5d25020b.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Randy.Dunlap wrote:

> | @@ -1318,7 +1318,9 @@
> |  	while(*status == 0){
> |  		if(time_after(jiffies,timeout)){
> |  			printk(KERN_WARNING"%s: IOP Reset Timeout\n",pHba->name);
> | -			kfree(status);
> | +			/* We loose 4 bytes of "status" here, but we cannot
> | +			   free these because controller may awake and corrupt
> | +			   those bytes at any time */
> s/loose/lose/
>
> | @@ -1336,6 +1338,9 @@
> |  			}
> |  			if(time_after(jiffies,timeout)){
> |  				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
> | +			/* We loose 4 bytes of "status" here, but we cannot
> | +			   free these because controller may awake and corrupt
> | +			   those bytes at any time */
> s/loose/lose/
>
> or is this a Brit vs. Amer difference?  (not that I know of)
>
> --
> ~Randy
> -

Loose means that something is rattling around, not connected, or
not tied down. Lose is what happens on the Crap Tables (as above).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

