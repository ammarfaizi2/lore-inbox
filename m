Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVCBOAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVCBOAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVCBOAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:00:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54802 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262295AbVCBOAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:00:25 -0500
Date: Wed, 2 Mar 2005 15:00:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, kai@germaschewski.name, sam@ravnborg.org,
       rusty@rustcorp.com.au
Cc: Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050302140019.GC4608@stusta.de>
References: <422550FC.9090906@gmail.com> <20050302012331.746bf9cb.akpm@osdl.org> <65258a58050302014546011988@mail.gmail.com> <20050302032414.13604e41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302032414.13604e41.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 03:24:14AM -0800, Andrew Morton wrote:
> Vincent Vanackere <vincent.vanackere@gmail.com> wrote:
> >
> > I have the exact same problem. 
> >  .config is attached
> >  (this may be a debian specific problem as I'm running debian too)
> 
> OK, there are no vmlinux references to lib/parser.o's symbols.  So it isn't
> getting linked in.

That much I figured out after Vincent sent his bug report two weeks ago.

> In lib/Makefile, remove parser.o from the lib-y: rule and add
> 
> obj-y	+= parser.o

This I didn't find.

Is it really the intention to silently omit objects that are not 
referenced or could this be changed?

Why doesn't an EXPORT_SYMBOL create a reference?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

