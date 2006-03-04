Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWCDUdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWCDUdo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 15:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWCDUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 15:33:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751516AbWCDUdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 15:33:43 -0500
Date: Sat, 4 Mar 2006 12:28:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: zippel@linux-m68k.org, torvalds@osdl.org, bunk@stusta.de,
       geert@linux-m68k.org, linux-m68k@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Message-Id: <20060304122848.188430e8.akpm@osdl.org>
In-Reply-To: <4409A05F.2090704@yahoo.com.au>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060303230149.GB9295@stusta.de>
	<Pine.LNX.4.64.0603031515321.22647@g5.osdl.org>
	<20060303155913.2e299736.akpm@osdl.org>
	<Pine.LNX.4.64.0603041457070.16802@scrub.home>
	<4409A05F.2090704@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Roman Zippel wrote:
> > Hi,
> > 
> > On Fri, 3 Mar 2006, Andrew Morton wrote:
> > 
> > 
> >>Yes, we now require cmpxchg of all architectures.
> > 
> > 
> > Actually I'd prefer if we used atomic_cmpxchg() instead.
> > The cmpxchg() emulation was never added for a good reason - to keep code 
> > from assuming it can be used it for userspace synchronisation. Using an 
> > atomic_t here would probably get at least some attention.
> > 
> 
> Yes, I guess that's what Andrew meant. The reason we can require
> atomic_cmpxchg of all architectures is because it is only guaranteed
> to work on atomic_t.
> 
> Glad to hear it won't be a problem for you though.
> 

Could someone with an m68k compiler please send the patch?
