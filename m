Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVLSTK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVLSTK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVLSTK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:10:29 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:57005 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932373AbVLSTK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:10:28 -0500
In-Reply-To: <1135014201.10933.4.camel@localhost>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net> <43A694DF.8040209@aitel.hist.no> <A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net> <1135014201.10933.4.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B1D5AEA1-A120-4997-AD9A-A2379B6A1779@comcast.net>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 19 Dec 2005 14:10:17 -0500
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 19, 2005, at 12:43 PM, Dumitru Ciobarcianu wrote:

> Sloppy coding ? As long you don't have the source you can't be sure.
> Point to an open source (and not tainting by just reading it) code  
> which
> uses >4k+IRQstack stacks.
>

First you gotta understand that I am not arguing to take away the 4K  
stacks - I am arguing about keeping both options and defaulting to 4K.

How do you determine how much stack space a piece of code is going to  
need without knowing what functionality it needs to build? There  
might be deeply nested, long call chains etc. which certain types of  
functionality might warrant. How do you prove "4K otta be enough  
stack for everyone doing everything", on what basis? (Reminds me of  
old DOS days and the famous statement relating to 640K)

> Millions of flyes eat shit.
> It must be a reason for having it...
>

Yeah, compare that same thing to FORCING 4K stacks - it sounds as  
illogical as the above statement.

No one is answering what are we gaining from removing the 8K stack  
"_option_" - few bytes of code size, reason to not fix the VM, for  
fun, for screwing over? Why not let people choose 8K if they need it?

Parag
