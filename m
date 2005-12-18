Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbVLRPtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVLRPtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVLRPtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:49:36 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:48040 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965180AbVLRPtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:49:35 -0500
In-Reply-To: <20051218120900.GA23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218120900.GA23349@stusta.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C3FD086-5582-4697-AB9F-578C80BA5811@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sun, 18 Dec 2005 10:49:31 -0500
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 18, 2005, at 7:09 AM, Adrian Bunk wrote:

> There is no workload where 8kB suits better.

People have pointed out that there is currently at least one  
incompatibility introduced by 4K stacks and there may be many others  
which are corner cases, that only occur under high load in obscure  
exceptional circumstances with large configurations and suitable  
nesting.

Moreover for 64 bit architectures there is no proven point that 4Kb  
stacks are solving a specific problem there (Like the lowmem  
fragmentation on i386 for e.g.). Nor can we predict for sure that in  
future no type of functionality will require more stack. So taking  
away 8Kb stack size on such arches solves no known problems and  
introduces artificial limitations on code complexity.

All I am asking is what is wrong with having options? You can even  
default to 4Kb and let people choose 8Kb when they absolutely benefit  
from it. Does having options introduce code bloat or what is it that  
is pressing so hard to remove the 8Kb "option"?

Parag
