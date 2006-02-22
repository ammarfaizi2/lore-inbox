Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWBVAhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWBVAhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWBVAhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:37:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422643AbWBVAhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:37:39 -0500
Date: Tue, 21 Feb 2006 16:34:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi, gregkh@suse.de,
       bunk@stusta.de, rml@novell.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060221162104.6b8c35b1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de>
 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
 <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org>
 <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Feb 2006, Andrew Morton wrote:
> 
> We.  Don't.  Do. That.
> 
> Please either restore the old events so we can have a 6-12 month transition
> period or revert the patch.

I agree.

This stupid argument of "HAL is part of the kernel, so we can break it" is 
_bogus_. 

The fact is, if changing the kernel breaks user-space, it's a regression. 
IT DOES NOT MATTER WHETHER IT'S IN /sbin/hotplug OR ANYTHING ELSE. If it 
was installed by a distribution, it's user-space. If it got installed by 
"vmlinux", it's the kernel.

The only piece of user-space code we ship with the kernel is the system 
call trampoline etc that the kernel sets up. THOSE interfaces we can 
really change, because it changes with the kernel.

		Linus
