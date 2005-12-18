Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVLRFnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVLRFnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 00:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVLRFnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 00:43:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39895 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030187AbVLRFnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 00:43:35 -0500
Date: Sun, 18 Dec 2005 06:43:23 +0100
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218054323.GF23384@wotan.suse.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 12:03:39AM -0500, Parag Warudkar wrote:
> 
> On Dec 17, 2005, at 3:52 PM, Adrian Bunk wrote:
> 
> >And in my experience, many stack problems don't come from code getting
> >more complex but from people allocating 1kB structs or arrays of
> 
> And we catch this type of problems fairly easily in the patch review  
> itself, even before accepting the code in mainline. Plus there is  

You can catch the obvious ones, but the really hard ones
that only occur under high load in obscure exceptional
circumstances with large configurations and suitable nesting you won't. 
These would be only found at real world users.

-Andi
