Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271705AbRIHRL2>; Sat, 8 Sep 2001 13:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271697AbRIHRLS>; Sat, 8 Sep 2001 13:11:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28431 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271705AbRIHRLI>; Sat, 8 Sep 2001 13:11:08 -0400
Subject: Re: "Cached" grows and grows and grows...
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sat, 8 Sep 2001 18:14:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mcelrath@draal.physics.wisc.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010908184758.696bb9d1.skraw@ithnet.com> from "Stephan von Krawczynski" at Sep 08, 2001 06:47:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15flgs-0004BN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> //      printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order)
>         return NULL;
> 
> If there is no printk, you will obviously not notice the problem. You can bet
> your car on not "seeing the problem".

That printk is commented out because its pointless and bogus noise. It just
causes confused bug reporting. The stuff that matters is cache sizes
shrinking back when we need memory not slowly eating the computer alive.

> Nevertheless there _is_ a problem, because nfs still fails on low mem situation
> when option "no_subtree_check" is _off_/not used.

In certain cases NFS will struggle. It isnt as bad in -ac as we use
GFP_KERNEL for nfs level reassembly. It happens in 2.2 as well tho.

Alan
