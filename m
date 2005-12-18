Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVLRGF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVLRGF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 01:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVLRGF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 01:05:56 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:44000 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751167AbVLRGFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 01:05:55 -0500
In-Reply-To: <20051218054323.GF23384@wotan.suse.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net>
Cc: Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sun, 18 Dec 2005 01:05:52 -0500
To: Andi Kleen <ak@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 18, 2005, at 12:43 AM, Andi Kleen wrote:

> You can catch the obvious ones, but the really hard ones
> that only occur under high load in obscure exceptional
> circumstances with large configurations and suitable nesting you  
> won't.
> These would be only found at real world users.

Yep, as it all depends on code complexity, some of these cases might  
not be "errors" at all - instead for that kind of functionality they  
might _require_ bigger stacks.

If you have 64 bit machines common place and memory a lot cheaper I  
don't see how it is beneficial to force smaller stack sizes without  
giving consideration to the code complexity, architecture and  
requirements.
(Solaris for example, seems to be going to have 16Kb kernel stacks on  
64 bit machines.)

So, please let's leave stack size as an option for users to choose  
and stop this 4Kb stack war. May be after a little rest I will start  
another one demanding 16Kb stacks :)

Parag
