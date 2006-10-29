Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965416AbWJ2UVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965416AbWJ2UVg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965418AbWJ2UVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:21:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965416AbWJ2UVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:21:35 -0500
Date: Sun, 29 Oct 2006 12:17:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
In-Reply-To: <Pine.LNX.4.60.0610291056470.4303@poirot.grange>
Message-ID: <Pine.LNX.4.64.0610291211160.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <20061014111458.GI30596@stusta.de> <Pine.LNX.4.60.0610291056470.4303@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2006, Guennadi Liakhovetski wrote:
> 
> I did search the archives, but it does seem to be the new one. r8169 
> network driver introduced in 2.6.19-rcX a set_mac_address function, which 
> doesn't work for me. It should resolve the bugreport 
> http://bugzilla.kernel.org/show_bug.cgi?id=6032 but, as you see from the 
> last comment from the original reporter and from my following comment, it 
> doesn't seem to. I think, it should either be fixed or reverted. My 
> test-system, was a ppc NAS (KuroboxHG):

Can you please test the things that Francois asks you to test in the last 
comment?

That said, it does appear that the patch breaks things for some people, 
and the upsides seem very limited - only relevant when somebody tries to 
change the MAC address, which is not a very normal thing to do anyway.

So maybe reverting it is the right thing to do. Guennadi, can you confirm 
that it is commit a2b98a69 ("r8169: mac address change support") that 
breaks it, and that reverting just that one commit fixes things for you?

But please check the things that are suggested in the bugzilla entry 
first.

Francois? Jeff?

		Linus
