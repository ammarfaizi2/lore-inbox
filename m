Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbRBVKUH>; Thu, 22 Feb 2001 05:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRBVKT6>; Thu, 22 Feb 2001 05:19:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24080 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129071AbRBVKTq>; Thu, 22 Feb 2001 05:19:46 -0500
Subject: Re: Linux 2.4.1-ac15
To: rusty@linuxcare.com.au (Rusty Russell)
Date: Thu, 22 Feb 2001 10:22:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        prumpf@mandrakesoft.com (Philipp Rumpf), linux-kernel@vger.kernel.org
In-Reply-To: <E14Vl7y-0001FG-00@halfway> from "Rusty Russell" at Feb 22, 2001 01:05:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Vstm-0003q3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We can take page faults in interrupt handlers in 2.4 so I had to use a 
> > spinlock, but that sounds the same
> 
> We can?  Woah, please explain.

vmalloc does a lazy load of the tlb. That can lead to the exception table 
being walked on an IRQ

