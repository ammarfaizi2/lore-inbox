Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbRE2IyU>; Tue, 29 May 2001 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbRE2IyK>; Tue, 29 May 2001 04:54:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261449AbRE2IyC>; Tue, 29 May 2001 04:54:02 -0400
Subject: Re: Plain 2.4.5 VM...
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 29 May 2001 09:51:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B12EE32.9B35F89F@mandrakesoft.com> from "Jeff Garzik" at May 28, 2001 08:32:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154fEE-0004AI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ouch!  When compiling MySql, building sql_yacc.cc results in a ~300M
> cc1plus process size.  Unfortunately this leads the machine with 380M of
> RAM deeply into swap:
> 
> Mem:   381608K av,  248504K used,  133104K free,       0K shrd,     192K
> buff
> Swap:  255608K av,  255608K used,       0K free                  215744K
> cached

That is supposed to hapen.  The pages are existing both in swap and memory but
not recovered. In that state the VM hasn't even broken yet. 

Where you hit a problem is that the 255Mb of stuff both in memory and swap
won't be flushed from swap when you need more swap space. That is a giant size
special edition stupid design flaw that is on the VM hackers list. But there
are only a finite number of patches you can do in a day, and things like
sucking completely came first I believe




