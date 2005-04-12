Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVDLBue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVDLBue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVDLBue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:50:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28683 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261896AbVDLBuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:50:19 -0400
Date: Tue, 12 Apr 2005 03:50:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Franco Sensei <senseiwa@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
Message-ID: <20050412015018.GA3828@stusta.de>
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425B1E3F.5080202@tin.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 08:02:55PM -0500, Franco Sensei wrote:
> Adrian Bunk wrote:
> >This has nothing to do with versioning.
> >
> >You are asking for ABI compatibility between different kernel versions.
> 
> The problem is probably misunderstanding about what I intend by version.
> 
> >There is no stable ABI between different kernel versions and there will 
> >never be one. Please read Documentation/stable_api_nonsense.txt for 
> >details.
> 
> I've read it.
> 
> Assuming the fact that a kernel can be considered stable, my point of
> view implies an assumption: kernel and modules are distributed by a
> distro, and compiled with the same gcc. Of course, I'm not talking about
> different architectures and so on, since I'm talking about something
> different, I'm talking about the api involved in the developement. 
> Distributions have to use a great care about compiler changes, and it's 
> not kernel developers' problem.
> 
> A kernel stable 2.X  version should not differ much in the
> subversioning (2.X.a ~= 2.X.b). Changing APIs in the kernel can be 

You say API but talk about ABI.

> possibly avoided by using a release versioning different from the one 
> used now. Structues and exported functions should be almost the same, 
> the implementation should be, and of course, must be different: bugs, 
> improvements and so on.

You said you've read stable_api_nonsense.txt .

stable_api_nonsense.txt talks about exactly these issues.

> I see the point about continuous developement, that's why I'm using 
> linux since 97, but I find interesting also the design of a stable 
> infrastructure, that can be achieved. A data structure no longer in use 
> by anyone, functions being unused for a long time, can be made harmless. 
> Providing a binary compatibility makes recompiling all external modules 
> (external to the official kernel I mean) not necessary, making life 
> easier for any other person using linux (e.g. pwc module for my logitech 
> pro 4000 webcam, every new kernel, new module compilation. Stability 
> makes in this sense a real big improvement. An example of this care can 

The right solution for this issue is simple:

Get the module into the kernel.

Not that e.g. your pwc module will be in kernel 2.6.12.

> be found in trolltech qt library. I use them since 1.x and it's a really 
> good thing assuring the binary compatibility... of course they just 
> screw it some day to day :) Everybody can be wrong.
>...

Please check the facts:

QT 1 is _not_ binary compatible with QT 3.

There's a reason why the library changed the so-name...


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

