Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbRGEQFC>; Thu, 5 Jul 2001 12:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265896AbRGEQEn>; Thu, 5 Jul 2001 12:04:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265895AbRGEQE2>; Thu, 5 Jul 2001 12:04:28 -0400
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
To: andrewm@uow.edu.au (Andrew Morton)
Date: Thu, 5 Jul 2001 17:04:24 +0100 (BST)
Cc: arjanv@redhat.com (Arjan van de Ven),
        thibaut@celestix.com (Thibaut Laurent),
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
In-Reply-To: <3B448E33.120DF382@uow.edu.au> from "Andrew Morton" at Jul 06, 2001 01:56:35 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IBc8-0002r3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My money is on the unconditional sti()'s in the cyrix code.

Possibly but the diff is wrong

> -	cli();
> +	save_flags(flags);

>>> cli() needed still


