Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTICDLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 23:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbTICDLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 23:11:16 -0400
Received: from smtp.terra.es ([213.4.129.129]:30022 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id S261508AbTICDLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 23:11:15 -0400
Message-ID: <3F555B68.2010408@terra.es>
Date: Wed, 03 Sep 2003 05:09:28 +0200
From: tonildg <tonildg@terra.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030830 Debian/1.4-3.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Willemoes Hansen <mwh@sysrq.dk>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Airo Net 340 PCMCIA WiFi Card trouble
References: <1062498150.356.9.camel@spiril.sysrq.dk>	 <20030902113610.D29984@flint.arm.linux.org.uk> <1062500366.642.11.camel@hugoboss.sysrq.dk>
In-Reply-To: <1062500366.642.11.camel@hugoboss.sysrq.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >The error message:
 >cardmgr[19]: starting, version is 3.2.4
 >cs: memory probe 0x0c0000-0x0ffff: excluding >0xc0000-0xcbfff

  I had the same problem you have (but in other range of memory and with 
another wireless card) and it started too with 2.4.19. 

 I solved it testing with memory ranges in the config.opts file that 
comes with your pcmcia_cs version.

   You have to play with them until one fits and boots. "I had to use 
windows to see the memory adresses my cardbus used." Usually, when 
comenting the "include memory 0xc0000-0xfffff" solves it.

However this problem is not caused by the Airo driver. And, (i think) it 
is not a  kernel problem. Maybe a pcmcia_cs one.

 >Sure, when I boot my laptop with any of the above mentioned kernels I
 >get the above message and the laptop freezes and stops whatever its
 >doing.


