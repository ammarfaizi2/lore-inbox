Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTHZIg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbTHZIg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:36:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:25574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263538AbTHZIfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:35:39 -0400
Date: Tue, 26 Aug 2003 01:38:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport_pc Oops with 2.6.0-test3
Message-Id: <20030826013829.73d00992.akpm@osdl.org>
In-Reply-To: <3F4AA6FF.9050601@g-house.de>
References: <200308160438.59489.gene.heskett@verizon.net>
	<1061030883.13257.253.camel@workshop.saharacpt.lan>
	<200308161107.21430.gene.heskett@verizon.net>
	<3F4AA6FF.9050601@g-house.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
>
>  >> > Can you retest on 2.6.0-test4?
>   >>
>   >> i have, but with no (?) changes:
>   >
>   > Please send your .config.

That helped, thanks.

--- 25/drivers/parport/parport_pc.c~parport_pc-rmmod-oops-fix	2003-08-26 01:32:59.000000000 -0700
+++ 25-akpm/drivers/parport/parport_pc.c	2003-08-26 01:33:08.000000000 -0700
@@ -93,7 +93,7 @@ static struct superio_struct {	/* For Su
 	int dma;
 } superios[NR_SUPERIOS] __devinitdata = { {0,},};
 
-static int user_specified __devinitdata = 0;
+static int user_specified;
 #if defined(CONFIG_PARPORT_PC_SUPERIO) || \
        (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
 static int verbose_probing;

_

