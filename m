Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbSLEHCE>; Thu, 5 Dec 2002 02:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbSLEHCE>; Thu, 5 Dec 2002 02:02:04 -0500
Received: from ns.suse.de ([213.95.15.193]:39172 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267244AbSLEHCD>;
	Thu, 5 Dec 2002 02:02:03 -0500
Date: Thu, 5 Dec 2002 08:09:37 +0100
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI notifiers for 2.5
Message-ID: <20021205070937.GA16766@wotan.suse.de>
References: <1039027142.20387.11.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel> <p731y4xtulg.fsf@oldwotan.suse.de> <1039038853.20387.19.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039038853.20387.19.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 01:54:13PM -0800, Stephen Hemminger wrote:
> 
> > For a more comprehensive variant see include/asm-x86_64/kdebug.h	
> > The x86-64 variant cannot be 1:1 copied because it's still incomplete
> > and e.g. does not implement veto for all places where it's needed.
> > 
> 
> Didn't look in x86_64 code.  Would it just make more sense to turn this
> into an architecture independent mechanism and provide sample versions
> for x86_64 and i386?

Would seem like overkill to me.

notifiers are already architecture independent, that should be enough.

My experience so far is that one has to be very careful how to design
such hooks and the first versions of it usually don't survive 
the actual implementation of an debugger or crash dumper.

-Andi
