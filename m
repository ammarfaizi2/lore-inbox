Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbSLFWl1>; Fri, 6 Dec 2002 17:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbSLFWl0>; Fri, 6 Dec 2002 17:41:26 -0500
Received: from host194.steeleye.com ([66.206.164.34]:25359 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267630AbSLFWlZ>; Fri, 6 Dec 2002 17:41:25 -0500
Message-Id: <200212062248.gB6Mmvh04649@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: James.Bottomley@SteelEye.com, adam@yggdrasil.com, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Fri, 06 Dec 2002 14:29:27 PST." <20021206.142927.88817589.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 16:48:57 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com said:
> It's like adding a new system call, and the same arguments apply.

> I don't want a 'flags' thing, because that tends to be the action
> which opens the flood gates for putting random feature-of-the-day new
> bits. 

I did think of this.  The flags are enums in include/linux/dma-mapping.h  In 
theory they can't be hijacked by an architecture without either changing this 
global header or exciting compiler warnings.

However, I can only see their being two types of drivers: those which do all 
the sync points and those which don't do any, so I can't see any reason for 
there to be any more than two such flags.

I also want an active discouragement from using the may return inconsistent 
API, and I think, given the general programmer predisposition not to want to 
type, that a long flag name (or a long routine name) does this.

I just don't like API names that look like

dma_alloc_may_be_inconsistent()

but if that's what it takes, I'll do it

James


