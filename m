Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRDLXLe>; Thu, 12 Apr 2001 19:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135379AbRDLXLY>; Thu, 12 Apr 2001 19:11:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41736 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135378AbRDLXLL>; Thu, 12 Apr 2001 19:11:11 -0400
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
To: andre@linux-ide.org (Andre Hedrick)
Date: Fri, 13 Apr 2001 00:12:31 +0100 (BST)
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org> from "Andre Hedrick" at Apr 12, 2001 02:52:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nqGQ-0001i5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay but what will be used for a base for hardware that has critical
> timing issues due to the rules of the hardware?

> #define WAIT_MIN_SLEEP  (2*HZ/100)      /* 20msec - minimum sleep time */
> 
> Give me something for HZ or a rule for getting a known base so I can have
> your storage work and not corrupt.


The same values would be valid with add_timer and friends regardless. Its just
that people who do

	while(time_before(jiffies, started+DELAY))
	{
		if(poll_foo())
			break;
	}

would need to either use add_timer or we could implement get_jiffies()


	
