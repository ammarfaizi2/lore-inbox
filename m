Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbTHZXD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTHZXD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:03:59 -0400
Received: from [62.75.136.201] ([62.75.136.201]:12188 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262035AbTHZXD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:03:58 -0400
Message-ID: <3F4BE75A.4000903@g-house.de>
Date: Wed, 27 Aug 2003 01:03:54 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: parport_pc Oops with 2.6.0-test3
References: <200308160438.59489.gene.heskett@verizon.net>	<1061030883.13257.253.camel@workshop.saharacpt.lan>	<200308161107.21430.gene.heskett@verizon.net>	<3F4AA6FF.9050601@g-house.de> <20030826013829.73d00992.akpm@osdl.org>
In-Reply-To: <20030826013829.73d00992.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>That helped, thanks.
>
>--- 25/drivers/parport/parport_pc.c~parport_pc-rmmod-oops-fix	2003-08-26 01:32:59.000000000 -0700
>+++ 25-akpm/drivers/parport/parport_pc.c	2003-08-26 01:33:08.000000000 -0700
>@@ -93,7 +93,7 @@ static struct superio_struct {	/* For Su
> 	int dma;
> } superios[NR_SUPERIOS] __devinitdata = { {0,},};
> 
>-static int user_specified __devinitdata = 0;
>+static int user_specified;
> #if defined(CONFIG_PARPORT_PC_SUPERIO) || \
>        (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
> static int verbose_probing;
>  
>
thank you Andrew for diggin' that much into this issue. but as i said 
before i don't really need parport_pc that much right now.
well, i do need. but i (too) don't have much time this week for testing 
and replying any faster to this issue.

Thank you for the patch, but it'll have to wait until tomorrow :-(

good night,
Christian.

