Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSEPP4I>; Thu, 16 May 2002 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSEPP4H>; Thu, 16 May 2002 11:56:07 -0400
Received: from bgp401130bgs.jersyc01.nj.comcast.net ([68.36.96.125]:36365 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S313384AbSEPP4H>;
	Thu, 16 May 2002 11:56:07 -0400
Date: Thu, 16 May 2002 11:55:00 -0400
Message-Id: <200205161555.g4GFt0v05623@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Bart Trojanowski <bart@jukie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: x86 interrupt arrival after cli
In-Reply-To: <20020515202720.D15996@jukie.net>
User-Agent: tin/1.5.11-20020130 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002 20:27:20 -0400, Bart Trojanowski <bart@jukie.net> wrote:
> [-- text/plain, encoding quoted-printable, 14 lines --]
> 
> Quick question for the x86 gurus:
> 
> If a hardware interrupt arrives within a spin_lock_irqsave &
> spin_unlock_irqrestore will the interrupt handler associated with said
> interrupt be called immediately after the spinlock is released?  
> 
> I am interested in any delays, even those less then a jiffie.

The interrupt will occur when the instruction after the "sti" finishes.
That's a one assembler instruction delay, i.e. a few clock cycles.

*Which* interrupt will be serviced first, however, depends on how 
many interrupt sources you have active and on the IRQ prioritization.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
