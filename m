Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWBAQij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWBAQij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWBAQij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:38:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161036AbWBAQii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:38:38 -0500
Date: Wed, 1 Feb 2006 11:38:18 -0500
From: Dave Jones <davej@redhat.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Chris Mason <mason@suse.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16rc1-git4 slab corruption.
Message-ID: <20060201163818.GG5875@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>, Chris Mason <mason@suse.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060131180319.GA18948@redhat.com> <200601311408.35771.mason@suse.com> <20060131221542.GC29937@redhat.com> <84144f020601312327t490dcf4fi6fb09942a0f3dd87@mail.gmail.com> <20060201160921.GC5875@redhat.com> <1138811364.8604.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138811364.8604.5.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 06:29:24PM +0200, Pekka Enberg wrote:
 > Hi Dave,
 > 
 > On Wed, 2006-02-01 at 11:09 -0500, Dave Jones wrote:
 > > @@ -1446,7 +1448,11 @@ next:
 > >  	} 
 > >  
 > >  	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
 > > -					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
 > > +					((unsigned long)cachep/L1_CACHE_BYTES)%REAPTIMEOUT_LIST3;
 > 
 > Hmm. This bit seems unrelated. Was it in the original patch?

as far as I recall, yes.

		Dave

