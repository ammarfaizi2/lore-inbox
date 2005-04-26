Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVDZUwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVDZUwf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDZUwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:52:35 -0400
Received: from mail.dif.dk ([193.138.115.101]:42957 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261778AbVDZUwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:52:33 -0400
Date: Tue, 26 Apr 2005 22:55:50 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Robert Love <rml@novell.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kpreempt-tech@lists.sourceforge.net
Subject: Re: preempt-count oddities - still looking for comments :)
In-Reply-To: <1114547317.6851.8.camel@betsy>
Message-ID: <Pine.LNX.4.62.0504262252460.2071@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504232254050.2474@dragon.hyggekrogen.localhost>
  <Pine.LNX.4.62.0504261929230.2071@dragon.hyggekrogen.localhost> 
 <1114536937.6851.1.camel@betsy>  <Pine.LNX.4.62.0504261944020.2071@dragon.hyggekrogen.localhost>
  <1114537590.6851.3.camel@betsy>  <Pine.LNX.4.62.0504262159330.2071@dragon.hyggekrogen.localhost>
 <1114547317.6851.8.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Robert Love wrote:

> On Tue, 2005-04-26 at 22:05 +0200, Jesper Juhl wrote:
> 
> > Hmm, one downside to using "s32" instead of plain "int" is that not all 
> > thread_info.h files get asm/types.h pulled in and then won't have that 
> > type defined (m68knommu is one such as far as I can see). Would this make 
> > "int" prefered after all or should I just include asm/types.h where needed 
> > or just include it everywhere? seems logical that the file that uses 
> > header includes it directly instead of it getting included implicitly by 
> > other headers (like i386 where thread_info.h includes asm/page.h that then 
> > includes asm/mmx.h that then includes linux/types.h that finally includes 
> > asm/types.h).
> > Personally I'd just add the asm/types.h include to all the thread_info.h 
> > files (or go back to using int) - what's your preference?
> 
> Well, guess it depends how much we like s32 over int.  Both are
> identical on all supported architectures, so it is just a style issue,
> really.
> 
> If m68knommu is the only arch needing asm/typed.h included, I'd so just
> include it.  If more and more arches need it, just go with int.
> 
Quite a few would need it (I just checked), so I'll just stick to int.

Thank you for taking the time to reply and comment on this very low 
priority thing. It's appreciated.

-- 
Jesper


