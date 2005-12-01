Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbVLAA5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbVLAA5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVLAA5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:57:06 -0500
Received: from ozlabs.org ([203.10.76.45]:19926 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751408AbVLAA5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:57:05 -0500
Subject: Re: Why does insmod _not_ check for symbol redefinition ??
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0511251029150.18002-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0511251029150.18002-100000@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 11:57:09 +1100
Message-Id: <1133398629.8128.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 10:45 +0530, Nagendra Singh Tomar wrote:
> Did'nt get any response to this one, so sending it again.
> 
> Can any of the module subsystem authors tell, why they have decided to 
> allow loading a kernel module having an EXPORTed symbol with the same name 
> as an EXPORTed  symbol in kernel proper. The safest thing would be to 
> disallow  module loading in this case, giving a "Symbol redefinition" 
> error.
> 	Allowing the module load will lead to overriding kernel functions
> which will affect modules loaded in future, that reference those 
> functions. Overall, it can have bad effects of varying severity.

Sure.  It was due to minimalism.  If you override a symbol it's
undefined behavior.  It should be fairly simple to add a check that
noone overrides a symbol.  We didn't bother checking for it because it
wasn't clear that it was problematic.

Hope that clarifies,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

