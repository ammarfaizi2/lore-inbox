Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUEJKs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUEJKs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 06:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbUEJKs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 06:48:59 -0400
Received: from ozlabs.org ([203.10.76.45]:4842 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264625AbUEJKsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 06:48:53 -0400
Subject: Re: 2.6.6-rc3-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andy Lutomirski <luto@myrealbox.com>, "R. J. Wysocki" <rjwysocki@sisk.pl>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040510054032.GA68320@colin2.muc.de>
References: <fa.gcf87gs.1sjkoj6@ifi.uio.no> <fa.freqmjk.11j6bhe@ifi.uio.no>
	 <409D3507.2030203@myrealbox.com> <20040509133231.GA25195@colin2.muc.de>
	 <1084141013.28220.8.camel@bach>  <20040510054032.GA68320@colin2.muc.de>
Content-Type: text/plain
Message-Id: <1084181022.31137.3.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 20:48:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 15:40, Andi Kleen wrote:
> On Mon, May 10, 2004 at 08:16:53AM +1000, Rusty Russell wrote:
> > How about debugging a known problem instead of whining how your arch was
> > broken by a simple change required to consolidate early parameter
> > parsing sanely?
> 
> I did that, found that your patch causes the breakage, reverted it 
> and it worked again. Sorry I don't have time right now to hunt
> for bugs in your patches.
> 
> Frankly such cleanups are more something for 2.7 anyways, they seem
> to be misplaced currently when we're all else trying to stabilize 2.6.
> After all it does not fix any bugs, just adds new ones.

For the record: I was surprised to see early_param() patches go into the
-mm tree during 2.6.  However, the way they were done was too invasive
and introduced a third parser in the kernel.  I reworked them to be
minimal and use existing parsers: this patch is 1/2 in that series.

> > I don't have an x86_64 box, and I ask *again* if someone who does can
> > take a look at the problem...
> 
> I would propose you defer these patches to 2.7 and then we try again.
> Hopefully there will be more time then to hunt issues in all kinds
> of cleanup patches.

I support that, if there's no real need for an arch-indep early_param().

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

