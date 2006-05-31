Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWEaXBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWEaXBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWEaXBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:01:32 -0400
Received: from ns.suse.de ([195.135.220.2]:56496 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965227AbWEaXBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:01:31 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: linux-2.6 x86_64 kgdb issue
Date: Thu, 1 Jun 2006 00:59:17 +0200
User-Agent: KMail/1.9.3
Cc: piet@bluelane.com, "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <446E0B4B.9070003@ru.mvista.com> <200605312301.56452.ak@suse.de> <20060531223515.GE31210@smtp.west.cox.net>
In-Reply-To: <20060531223515.GE31210@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606010059.17859.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 00:35, Tom Rini wrote:
> On Wed, May 31, 2006 at 11:01:56PM +0200, Andi Kleen wrote:
> > On Wednesday 31 May 2006 17:03, Tom Rini wrote:
> > > On Wed, May 31, 2006 at 09:13:53AM +0200, Andi Kleen wrote:
> > >
> > > [snip]
> > >
> > > > Yes because you if modular works you don't need to build it in.
> > > >
> > > > Modular was working at some point on x86-64 for kdb and the original 2.6
> > > > version of kgdb was nearly there too.
> > >
> > > FWIW, the only change the current version of kgdb makes that would
> > > prevent it from being totally modular is the debugger_active check in
> > 
> > Can you post the patch and a description? 
> 
> The change is a simple if (atomic_read(&debugger_active)) return right
> at the start.  And I'm embarrased to say the change predates me on the
> project so I'm not 100% sure on the lineage and it might be totally
> bogus now.

And why do you need it?  Where does the debugger call might sleep? 

-Andi
 
