Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbSL3VAm>; Mon, 30 Dec 2002 16:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbSL3VAm>; Mon, 30 Dec 2002 16:00:42 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:58542 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267084AbSL3VAk>; Mon, 30 Dec 2002 16:00:40 -0500
Subject: Re: [PATCH] 2.5 fix link with fbcon built-in
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0212301201090.2812-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212301201090.2812-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041282678.550.13.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 30 Dec 2002 22:11:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 21:03, Linus Torvalds wrote:
> On 30 Dec 2002, Benjamin Herrenschmidt wrote:
> >
> > In current bk 2.5, drivers/video/console/fonts.c exports an
> > init_module() symbol when built-in, which prevents the kernel from
> > linking. Here's a quick fix.
> 
> This is not correct.
> 
> The functions should either be removed completely (preferred, since they 
> aren't even proper C syntax in the first place - since when do we put 
> semicolons at the end of a function?) or the file should be taught to use 
> proper "module_init()/module_exit()" semantics that work _correctly_ for 
> both modules and built-in.
> 
> The patch just hides just _how_ crap this file is, and as such should not 
> be applied. Crap doesn't get better from being hidden.

Right, though weren't those empty functions just workarounds for a time
where new module stuff didn't grok modules without module init/exit ? Is
this still the case ? If not, then we should indeed just remove the
function completely.

Ben.



