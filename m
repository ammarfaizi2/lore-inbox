Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUBEBEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUBEBDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:03:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:35792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265111AbUBDXxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:53:33 -0500
Date: Wed, 4 Feb 2004 15:54:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, amitkale@emsyssoft.com
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040204155452.49c1eba8.akpm@osdl.org>
In-Reply-To: <402182B8.7030900@timesys.com>
References: <20040204230133.GA8702@elf.ucw.cz>
	<20040204152137.500e8319.akpm@osdl.org>
	<402182B8.7030900@timesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"La Monte H.P. Yarroll" <piggy@timesys.com> wrote:
>
> Andrew Morton wrote:
> 
> >Pavel Machek <pavel@ucw.cz> wrote:
> >  
> >
> >>It seems that some kgdb support is in 2.6.2-linus:
> >>    
> >>
> >
> >Lots of architectures have had in-kernel kgdb support for a long time. 
> >Just none of the three which I use :(
> >
> >I wouldn't support inclusion of i386 kgdb until it has had a lot of
> >cleanup, possible de-featuritisification and some thought has been applied
> >to splitting it into arch and generic bits.  It's quite a lot of work.
> >  
> >
> 
> Amit has started at least the third activity--he has split much of kgdb
> into arch and generic bits.

Yes.

> Could you elaborate a little on the first two?
> 
> What major kinds of cleanup are we talking about?  Style issues?

Coding style compliance, reduction of ifdefs, etc.  Reduction of patch
footprint.  There are a few features in the patch in -mm which I am not
aware of anyone having used.

> What features (or classes of features) do you find excessive?  Would
> it be sufficient to add a few config items to control subfeatures
> of kgdb?
> 

People have added timestamping infrastructure, stack overflow testing and
inbuilt assertion frameworks to various gdb stubs at various times.  We
need to take a look at such things and really convice ourselves that
they're worthwhile.  Personally, I'd only be interested in the basic stub.

I need to take a look at Amit's current patch - it sounds good.

