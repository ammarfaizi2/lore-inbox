Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUAZOid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUAZOid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:38:33 -0500
Received: from colin2.muc.de ([193.149.48.15]:34317 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263636AbUAZOib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:38:31 -0500
Date: 26 Jan 2004 15:36:23 +0100
Date: Mon, 26 Jan 2004 15:36:23 +0100
From: Andi Kleen <ak@muc.de>
To: John Stoffel <stoffel@lucent.com>
Cc: Andi Kleen <ak@muc.de>, Adrian Bunk <bunk@fs.tum.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040126143623.GB337@colin2.muc.de>
References: <20040125191232.GC16962@colin2.muc.de> <16404.9520.764788.21497@gargle.gargle.HOWL> <20040125202557.GD16962@colin2.muc.de> <16404.10496.50601.268391@gargle.gargle.HOWL> <20040125214920.GP513@fs.tum.de> <16404.20183.783477.596431@gargle.gargle.HOWL> <20040125234756.GF28576@colin2.muc.de> <16404.34836.753760.759367@gargle.gargle.HOWL> <20040126050431.GB6519@colin2.muc.de> <16405.8396.359717.70413@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16405.8396.359717.70413@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 09:14:36AM -0500, John Stoffel wrote:
> 
> >> On node 0 totalpages: 196606
> >> DMA zone: 4096 pages, LIFO batch:1
> >> Normal zone: 192510 pages, LIFO batch:16
> >> HighMem zone: 0 pages, LIFO batch:1
> 
> Andi> Ok, it didn't oops. Just hung early. Probably needs some printks
> Andi> to track it down.
> 
> Andi> And the problem really goes away when you disable -funit-at-a-time ?
> 
> This was from both 2.6.2-rc1 and 2.6.2-rc2, and since the later
> doesn't have the -funit-at-time declaration in the Makefile, I don't
> think that's the problem.
> 
> My gcc version is:
> 
>     > gcc --version
>     gcc.real (GCC) 3.3.3 20040110 (prerelease) (Debian)

Well, you have some different problem then. I was assuming you used
-funit-at-a-time because you posted on the unit-at-a-time thread.
I don't know what's wrong with your kernel, sorry.

If it happened to me here I would add printks to the early kernel 
initialisation until I figured out where it hangs.
(it's somewhere after mem_init and before console_init in 
init/main.c:start_kernel). You could try that, together with earlyprintk. 

-Andi
