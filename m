Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264539AbUD1A2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUD1A2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUD1A2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:28:54 -0400
Received: from ozlabs.org ([203.10.76.45]:62358 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264539AbUD1A2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:28:51 -0400
Date: Wed, 28 Apr 2004 10:25:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marc Boucher <marc@linuxant.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040428002516.GC3272@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Marc Boucher <marc@linuxant.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:02:03PM -0400, Marc Boucher wrote:
> 
> Rusty, the workaround was done a while ago, back in the 2.5 days
> when your new module code was still very much in flux. It was
> necessary to have an effective short-term solution for the existing
> installed base (2.4), since we could not continue to confuse
> customers while waiting for the patch to propagate. In other cases,
> we have gladly submitted patches when we encountered bugs and could
> fix them. Had we known that the module fix was so simple, it would
> of course have been submitted it to you in parallel.

No, it wasn't *necessary*:  you made a choice that not confusing your
customers was more important to you than not increasing the support
burden on kernel developers by releasing a silently tainted module
into the wild.

That might make sense from your business perspective, but you must
accept its consequences: anger from those you've inconvenienced for
your benefit.  There's no reason they should give a fuck if your
customers are confused or not.

> Also since you and I have worked well together in other projects
> (netfilter core) and are long time friends, I don't understand why
> you are so quick to question my integrity in public. We didn't lie
> about anything; the license text is perfectly clear, 

No, it's only clear if someone looks at the module's source (what's
available of it), in which case the license would presumably be clear
from comments or documentation anyway.  The main purpose of the
MODULE_LICENSE() macro is to label the *module binary* with the
license.  To the standard tools that look at it there, it says "GPL"
which is clearly misleading.

>and the
> political situation with Conexant's proprietary signal processing
> code outside of our control.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
