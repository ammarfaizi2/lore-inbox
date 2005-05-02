Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVEBTg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVEBTg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVEBTg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:36:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:62644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261731AbVEBTgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:36:46 -0400
Date: Mon, 2 May 2005 12:36:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: venkatesh.pallipadi@intel.com, racing.guo@intel.com, luming.yu@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-Id: <20050502123609.19f18124.akpm@osdl.org>
In-Reply-To: <20050502191159.GI27150@muc.de>
References: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com>
	<20050502171551.GG27150@muc.de>
	<20050502113125.19320ceb.akpm@osdl.org>
	<20050502191159.GI27150@muc.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Mon, May 02, 2005 at 11:31:25AM -0700, Andrew Morton wrote:
>  > Andi Kleen <ak@muc.de> wrote:
>  > >
>  > >  > 
>  > >  > Doing it either way should be OK with this mce code. But I feel, 
>  > >  > despite of the patch size, it is better to keep all the shared 
>  > >  > code in i386 tree and link it from x86-64. Otherwise, it may become 
>  > >  > kind of messy in future, with various links between i386 and x86-64.
>  > > 
>  > >  i386 already uses code from x86-64 (earlyprintk.c) - it is nothing 
>  > >  new.
>  > 
>  > I must say I don't like the bidirectional sharing either.
> 
>  Why exactly?

One reason is that it makes it harder to locate the code.  I ctag each of
my architecture trees only with stuff from ./arch/that-architecture to reduce
duplicate hits.  So I end up with some x86 functions being unlocatable in
the x86 tree.  We end up with both x86_64 and x86 being broken in this
regard.

But that's a relatively minor point.  The major point is that it gives me
the creeps in hard-to-define ways ;)

