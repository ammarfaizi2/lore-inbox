Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312308AbSDNNvs>; Sun, 14 Apr 2002 09:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312311AbSDNNvr>; Sun, 14 Apr 2002 09:51:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51467 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312308AbSDNNvr>; Sun, 14 Apr 2002 09:51:47 -0400
Subject: Re: Memory Leaking. Help!
To: ivan@es.usyd.edu.au (ivan)
Date: Sun, 14 Apr 2002 15:05:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204142204330.19694-100000@dipole.es.usyd.edu.au> from "ivan" at Apr 14, 2002 10:23:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16wkde-0004MR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 10 Days ago I installed DNS and DHCPd servers from RedHat and noticed that 
> "top" shows the amount of consumed memory is slowly and constantly 
> growing. Machine became unstable and a few users complained that their 
> files disappeared. ( we have good backup ). I re-booted 4 days ago and now 
> it looks it is doing it again. Could this be BIND?

Wildly improbable. Slow shifts in memory usage occur naturally so don't be 
totally mislead by it. Named for example will grow and shrink over time 
according to what it has cached and what people asked for.

> 1) Could you please advice how can I detect memory leaks. ( I guess it is 
> not an easy task on production server.
> 
> 2) Is there a tool which I can use to log memory usage 

ps, looking in /proc at the address space maps too.

What you almost certainly want to do first is run memtest86 as suggested
by others. 

