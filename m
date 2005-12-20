Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVLUL72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVLUL72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVLUL72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:59:28 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48824 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932376AbVLUL71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:59:27 -0500
Message-Id: <200512202137.jBKLbY77004191@laptop11.inf.utfsm.cl>
To: kernel-stuff@comcast.net (Parag Warudkar)
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from kernel-stuff@comcast.net (Parag Warudkar) 
   of "Tue, 20 Dec 2005 19:08:24 -0000." <122020051908.25484.43A856A8000A6E600000638C220075894200009A9B9CD3040A029D0A05@comcast.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Tue, 20 Dec 2005 18:37:34 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 21 Dec 2005 08:56:08 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
> > Oh, well, one of the larger drawbacks of 4KiB stacks is the inevitable
> > flamewar, each time with /less/ data (this round I've seen none) supporting
> > the need for larger stacks, into which all kinds of idiots* are suckered.

> At the same time, I haven't seen any data showing what we gain by losing
> the 8K stack option.

Code simplification (don't need both versions). Simpler kernel configuration. 
Even smaller .config files ;-)

A useful byproduct is more reproducible crashes when the stack overruns (as
8KiB stands, it will crash the same, but only sometimes; probably even
more, as it really is 6KiB for process + IRQ, and with 4KiB they are 4KiB
each). Yes, more crashes is a feature, as it gets fixed faster.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
