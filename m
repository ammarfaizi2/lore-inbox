Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266715AbRGFPEE>; Fri, 6 Jul 2001 11:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266714AbRGFPDy>; Fri, 6 Jul 2001 11:03:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60434 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266716AbRGFPDg>; Fri, 6 Jul 2001 11:03:36 -0400
Subject: Re: scheduling in kmalloc()
To: pvvvarma@techmas.hcltech.com (Vasu Varma P V)
Date: Fri, 6 Jul 2001 16:03:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel Linux)
In-Reply-To: <3B45A7C1.7E684A7@techmas.hcltech.com> from "Vasu Varma P V" at Jul 06, 2001 05:27:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IX97-0004Uc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if we use any thing other than GFP_ATOMIC, does it result in scheduling
> out the process if there is no memory available?
> with GFP_KERNRL, I think we try freeing pages to service the current
> request.
> or is there any possibility of kmalloc() failing even with GFP_KERNEL?

kmalloc can always fail, looping on a kmalloc at high level can almost always
cause deadlocks so you need to be prepared to fail 

