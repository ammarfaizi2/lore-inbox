Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUGIWSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUGIWSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUGIWSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:18:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41205 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266001AbUGIWSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:18:03 -0400
Date: Sat, 10 Jul 2004 00:17:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040709221755.GU28324@fs.tum.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org> <20040709184050.GR28324@fs.tum.de> <20040709215415.GA56272@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709215415.GA56272@muc.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 11:54:15PM +0200, Andi Kleen wrote:
> > Runtime errors caused with gcc 3.4 are IMHO much worse than such a small 
> > improvement or three dozen compile errors with gcc 3.4 .
> 
> What runtime errors? 
> 
> Actually requiring inlining is extremly rare and such functions should
> get that an explicit always inline just for documentation purposes.
> (another issue is not optimized away checks, but that shows at link time) 

First of all, your proposed patch seems to be broken WRT gcc < 3.1 .

> In the x86-64 case it was vsyscalls, in Nigel's case it was swsusp.
> Both are quite exceptional in what they do.
> 
> > Wouldn't it be a better solution if you would audit the existing inlines 
> > in the kernel for abuse of inline and fix those instead?
> 
> I don't see any point in going through ~1.2MLOC of code by hand
> when a compiler can do it for me.

How can a compiler decide whether an "inline" was for a possible small  
speed benefit or whether it's required for correct working?

And I'm not that happy with the fact that gcc 3.3 and gcc 3.4 will 
produce significantly different code for the same file. Besides from the  
3 dozen compile errors I'm currently sorting out, gcc 3.3 and 3.4 should 
behave similar with __attribute__((always_inline)).

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

