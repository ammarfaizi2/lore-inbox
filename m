Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270648AbTHCU7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271106AbTHCU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:59:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45465 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270648AbTHCU7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:59:03 -0400
Subject: Re: sleeping in dev->tx_timeout?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Abraham van der Merwe <abz@frogfoot.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Discussions <linux-kernel@vger.kernel.org>
In-Reply-To: <3F2D6727.8070203@pobox.com>
References: <20030803183707.GA13728@oasis.frogfoot.net>
	 <Pine.LNX.4.53.0308031505390.3473@montezuma.mastecende.com>
	 <20030803193708.GA13992@oasis.frogfoot.net>  <3F2D6727.8070203@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059944094.31901.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Aug 2003 21:54:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-03 at 20:48, Jeff Garzik wrote:
> These days drivers often need quite a while for hardware reset.  I am 
> pushing to move this code, long term, into process context.  So, in 
> tx_timeout:
> * disable NIC and interrupts as best you can, quickly
> * schedule_task/schedule_work to schedule the full hardware reset

And if the hardware is hard to recover or needs messy recovery code take
a look at the PCI layer tricks in -ac

