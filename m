Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759285AbWLARgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759285AbWLARgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759281AbWLARgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:36:50 -0500
Received: from colo.lackof.org ([198.49.126.79]:39823 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1759285AbWLARgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:36:49 -0500
Date: Fri, 1 Dec 2006 10:36:47 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andrew Morton <akpm@osdl.org>,
       matthew@wil.cx, kyle@parisc-linux.org, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] parisc: "extern inline" -> "static inline" (fwd)
Message-ID: <20061201173647.GB10549@colo.lackof.org>
References: <20061201114811.GQ11084@stusta.de> <20061201164354.GA10549@colo.lackof.org> <20061201165427.GD11084@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201165427.GD11084@stusta.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 05:54:27PM +0100, Adrian Bunk wrote:
> If you read John David Anglin's email, you'll note that if you take the 
> address you need this function provided somewhere.

Let me turn that around.
Which of the "extern inline" functions are we taking the address?
The parisc kernel wouldn't (shouldn't) link if that were true.

> Which of the functions my patch changes also have a global function 
> provided within the kernel?
> 
> If none, "extern inline" didn't make any sense.

I expect none.

...
> Currently, "inline" is defined to be always_inline, and 
> __always_inline is for cases that produce non-compiling or non-working 
> (opposed to only suboptimal) code.

Ok.  Sounds like "extern inline" is the same as __always_inline.

Has gcc community confirmed "gcc -Wmissing-prototypes" behavior
is really correct with respect to "extern inline"?

If so, I'm ok with changing "extern inline" to __always_inline.

thanks,
grant
