Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTIOOBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbTIOOBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:01:04 -0400
Received: from dyn-ctb-210-9-244-189.webone.com.au ([210.9.244.189]:44550 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261336AbTIOOA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:00:58 -0400
Message-ID: <3F65C611.80203@cyberone.com.au>
Date: Tue, 16 Sep 2003 00:00:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Meadors <twrchris@hereintown.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <200309151146.h8FBkXcw001170@81-2-122-30.bradfords.org.uk>	 <3F65B2BD.9000206@cyberone.com.au> <1063633563.215.16.camel@clubneon.priv.hereintown.net>
In-Reply-To: <1063633563.215.16.camel@clubneon.priv.hereintown.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Meadors wrote:

>On Mon, 2003-09-15 at 08:38, Nick Piggin wrote:
>
>
>>OK, the reason why I don't like the sound of this is because the size
>>of your option set has now been squared, and its no longer "make these
>>CPUs work".
>>
>
>The way I see the config option working is, having a sub-menu that says
>something like, "Select the CPU the kernel will be run on."  From there
>you can pick one CPU.  This sets the in kernel optimizations for that
>CPU, along with the work arounds (obviously).  It also sets the compiler
>flags for the padding, and "-march=[CPU]".  Then in a sub-menu of this
>menu, there is an "Advanced processor selection".  The help text would
>be something like, "In addition to the primary processor selected above,
>also allow this kernel to be booted on the processors selected below. 
>Selecting this option disables some of the optimizations for the primary
>processor."  Just turning on that option would change the "-march=" to
>"-mcpu=".  Then in the menu one could select from any of the CPUs
>listed.  Each one would enable the work around code to allow the built
>kernel to run correctly on a machine with a different CPU.
>
>I see this as sort of like the advanced partition selection, or the
>compiled in fonts.
>

Look at the complexity though!

>
>>I can see an argument for cache line size but thats about it. I can't
>>think of my optimisations that should be done on one architecture but
>>not another.
>>
>
>Don't forget the compiler optimization flags.  A kernel built with
>"-march" may not run on any other CPUs.
>

Yeah, I really meant _should_, not must. In other words, something that
is an optimisation for one architecutre, but a pessimisation for
another.

