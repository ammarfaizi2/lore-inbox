Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVLRFDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVLRFDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 00:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVLRFDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 00:03:53 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19658 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965076AbVLRFDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 00:03:52 -0500
In-Reply-To: <20051217205238.GR23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sun, 18 Dec 2005 00:03:39 -0500
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 17, 2005, at 3:52 PM, Adrian Bunk wrote:

> And in my experience, many stack problems don't come from code getting
> more complex but from people allocating 1kB structs or arrays of

And we catch this type of problems fairly easily in the patch review  
itself, even before accepting the code in mainline. Plus there is  
make checkstack to help find and fix any such issues, isn't it? So  
it's not like forcing the stack to 4Kb and making the offending code  
to crash is the best solution to force people to write code which  
plays nice with the stack.

I think on i386 most people do fine with the 8Kb stack - whoever  
benefits from 4Kb stack, can always choose the 4Kb stack config  
option and recompile.

Alternatively, default to 4Kb and let people choose 8Kb and recompile  
if that's what suits their workloads.

In any case having options doesn't hurt anything and we don't benefit  
in any way from taking away the 8Kb option.

My 2 cents.

Parag


