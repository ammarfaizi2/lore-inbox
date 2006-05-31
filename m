Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWEaWfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWEaWfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWEaWfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:35:18 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37541 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965214AbWEaWfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:35:16 -0400
Date: Wed, 31 May 2006 15:35:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: piet@bluelane.com, "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.6 x86_64 kgdb issue
Message-ID: <20060531223515.GE31210@smtp.west.cox.net>
References: <446E0B4B.9070003@ru.mvista.com> <200605310913.54758.ak@suse.de> <20060531150343.GZ31210@smtp.west.cox.net> <200605312301.56452.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605312301.56452.ak@suse.de>
Organization: Embedded Alley Solutions, Inc
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 11:01:56PM +0200, Andi Kleen wrote:
> On Wednesday 31 May 2006 17:03, Tom Rini wrote:
> > On Wed, May 31, 2006 at 09:13:53AM +0200, Andi Kleen wrote:
> >
> > [snip]
> >
> > > Yes because you if modular works you don't need to build it in.
> > >
> > > Modular was working at some point on x86-64 for kdb and the original 2.6
> > > version of kgdb was nearly there too.
> >
> > FWIW, the only change the current version of kgdb makes that would
> > prevent it from being totally modular is the debugger_active check in
> 
> Can you post the patch and a description? 

The change is a simple if (atomic_read(&debugger_active)) return right
at the start.  And I'm embarrased to say the change predates me on the
project so I'm not 100% sure on the lineage and it might be totally
bogus now.

-- 
Tom Rini
