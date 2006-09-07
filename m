Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbWIGBXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbWIGBXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 21:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWIGBXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 21:23:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54973 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965286AbWIGBXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 21:23:34 -0400
Date: Thu, 7 Sep 2006 03:23:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <20060907010235.GE25473@stusta.de>
Message-ID: <Pine.LNX.4.64.0609070313420.6761@scrub.home>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de>
 <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de>
 <Pine.LNX.4.64.0609070115270.6761@scrub.home> <20060906235029.GC25473@stusta.de>
 <Pine.LNX.4.64.0609070202040.6761@scrub.home> <20060907003758.GD25473@stusta.de>
 <Pine.LNX.4.64.0609070245100.6761@scrub.home> <20060907010235.GE25473@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Sep 2006, Adrian Bunk wrote:

> > Define "full libc".
> 
> Everything described in clause 7 of ISO/IEC 9899:1999.

Its behaviour is also defined by the environment, so what gcc can assume 
is rather limited and you have not shown a single example, that any such 
assumption would be invalid for the kernel.

> > Explain what exactly -ffreestanding fixes, which is not valid for the 
> > kernel.
> 
> It's simply correct since the kernel doesn't provide everything 
> described in clause 7 of ISO/IEC 9899:1999.
> 
> And it fixes compile errors caused by the fact that gcc is otherwise 
> allowed to replace calls to any standard C function with semantically 
> equivalent calls to other standard C functions - in a hosted environment 
> the latter are guaranteed to be present.

The kernel uses standard C, so your point is?
You already got two NACKs from arch maintainers, why the hell are you 
still pushing this patch? The builtin functions are useful and you want to 
force arch maintainers to have to enable every single one manually and 
to maintain a list of these functions over multiple versions of gcc?

bye, Roman
