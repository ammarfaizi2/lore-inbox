Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271185AbRHTKXv>; Mon, 20 Aug 2001 06:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271187AbRHTKXl>; Mon, 20 Aug 2001 06:23:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24326 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271185AbRHTKX3>; Mon, 20 Aug 2001 06:23:29 -0400
Subject: Re: BUG: pc_keyb.c
To: lars.segerlund@comsys.se (Lars Segerlund)
Date: Mon, 20 Aug 2001 11:26:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
In-Reply-To: <no.id> from "Lars Segerlund" at Aug 20, 2001 07:57:23 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YmG8-0005kb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Due to writing to the status register before it's ready as far as I 
> can se.
> 
>   fix: change all mdelay(1) in pc_keyb.c to mdelay(2)'s .. ( mdelay(1) 
> will be on the timing limit.

Thats interesting. I thought the rule was 1mS. (There is indeed a timing
requirement). Any keyboard controller experts around ?

>   Might also be present during high load on machines running GL on AGP 
> video cards, not 100 % sure same symptoms, above seem's to fix ???? ( 
> strange ).

XFree86 touches they keyboard controller directly unless you rebuild it 
against a recent -ac kernel. This causes amusing problems with legacy free
PC's as well as the timing issue.

That might explain the other one


