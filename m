Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWDZID2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWDZID2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 04:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWDZID2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 04:03:28 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30994 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751156AbWDZID1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 04:03:27 -0400
Date: Wed, 26 Apr 2006 10:03:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: David Wilk <davidwilk@gmail.com>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
Message-ID: <20060426080326.GD9359@stusta.de>
References: <20060419192803.GA19852@kroah.com> <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com> <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com> <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com> <20060421192743.GH3061@sorel.sous-sol.org> <a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com> <Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com> <a4403ff60604241359q408a6ea7je620cb05d3dafe8@mail.gmail.com> <a4403ff60604251108x7ed6d4e3q10cb3597ea27876c@mail.gmail.com> <p73fyk09ayc.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fyk09ayc.fsf@bragg.suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 07:12:43AM +0200, Andi Kleen wrote:
> "David Wilk" <davidwilk@gmail.com> writes:
> 
> > Ok, I think I need to apologize to everyone here.  I have found the
> > problem, and it is not with your patch, Hugh.  For some reason, the
> > config for my 2.6.16.7 source tree had a 1G/3G user/kernel split
> > configured.  This is very bizaar as I copy my .config from tree to
> > tree to avoid any changes in the configuration of my test kernels.
> 
> This just shows this dreaded VMSPLIT config was a bad idea in the first
> place. There was a reason we didn't have it for such a long time (too
> many users get it wrong) and such occurrences just show again that this
> is still true.
> 
> IMHO it would be best to just remove that option again and require
> users who really want to change this to patch their kernels again.
> 
> At the very least it should be probably made dependent on CONFIG_EMBEDDED.

NAK, EMBEDDED has a different semantics (space savings in memory limited 
situations) that does not apply to this option.

> -Andi
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

