Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270034AbTGPBfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270040AbTGPBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:35:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39110
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270034AbTGPBff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:35:35 -0400
Date: Wed, 16 Jul 2003 03:50:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc-3.3.1-hammer breaks mm/memory.c
Message-ID: <20030716015001.GA4978@dualathlon.random>
References: <20030715222701.GC3823@werewolf.able.es> <20030716000532.GC2447@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716000532.GC2447@werewolf.able.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:05:32AM +0200, J.A. Magallon wrote:
> 
> On 07.16, J.A. Magallon wrote:
> > Hi all...
> > 
> > After some binary search and a 'couple' kernel builds, I narrowed the
> > problem to mm/memory.c. With that file built at -O1:
> > 
> > CFLAGS_memory.o = -O1
> > 
> > The kernel boots, starts /sbin/init and looks like working normally
> > (2.4.22-pre5).
> > 
> > Anybody can see what is miscompiled with an assembler listing ?
> > Any #pragma to switch optmizations on the half of a file or for
> > a function ?
> > 
> 
> I finally got this: -O2 fails but
> 
> CFLAGS_memory.o = -Os -falign-functions -falign-jumps -falign-loops -falign-labels -fprefetch-loop-arrays -freorder-blocks
> 
> works.
> 
> Those are specific options disabled by -Os, but -Os does more things...
> (assembler output is very different)
> 
> Any SuSE site (hammer comes from SuSE, isn't it ?) to submit a decent
> bug report ?

bugs@x86-64.org should be appropriate.

Andrea
