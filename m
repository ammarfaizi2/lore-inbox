Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVDKPS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVDKPS1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVDKPS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:18:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19435 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261754AbVDKPST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:18:19 -0400
Date: Mon, 11 Apr 2005 08:18:32 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
Message-ID: <20050411151832.GA1301@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050408030835.4941cd98.akpm@osdl.org> <20050410224834.GK4204@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410224834.GK4204@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 12:48:34AM +0200, Adrian Bunk wrote:
> kernel-rcupdatec-make-the-exports-export_symbol_gpl.patch
> add-deprecated_for_modules.patch
> add-deprecated_for_modules-fix.patch
> deprecate-synchronize_kernel-gpl-replacement.patch
> deprecate-synchronize_kernel-gpl-replacement-fix.patch
> change-synchronize_kernel-to-_rcu-and-_sched.patch
> 
> 
> Please drop these patches.

Please keep them!

> Using these symbols in non-GPL modules is a legal problem at least in 
> the USA except for IBM,

Again, based on what line of reasoning?  Again, the obvious lines
of reasoning do not apply.

>                         and all we've heard from IBM is that they are 
> not 100% sure that there is really no binary-only module by IBM that 
> might use these symbols.

>From my earlier message (http://lkml.org/lkml/2005/4/4/244):

	Agreed, in that I know of no binary module that uses RCU.  However,
	I cannot -prove- that there is no such module.

IOW, I am also not 100% sure that there is really no binary-only module
using these symbols by -anyone-, including someone -other- than IBM.
In addition, I know of no way that -anyone- could possibly be 100% sure
that there is really no binary-only module using symbols.  Hence the
approach of providing the year "grace period" before transitioning to
EXPORT_SYMBOL_GPL().

> The risk of anyne using them only increases (no matter that it's marked 
> as deprecated) as long as it's available - and nobody has until now 
> claimed that he's actually using one pf them in a binary-only module.

I am not convinced that the risk of usage increases significantly.
However, even if someone does start using them in a binary module, they
will have been warned.  Yes, someone could possibly ignore the warning.
They -still- will have been warned, so that any "damage" would be
self-inflicted.  Therefore, as noted earlier, the symbol transitions
to EXPORT_SYMBOL_GPL() one year after its inclusion, regardless of any
people who ignored warnings.

							Thanx, Paul

> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> 
> 
