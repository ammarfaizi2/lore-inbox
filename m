Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbVKWLHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVKWLHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbVKWLHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:07:43 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:42257 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030401AbVKWLHm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:07:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iPlBa1gSn3BYw3g0SlFSLiVONG0zyc4xgpUx3aI1rjCMruY7UUxT7CeUlgzXkkvXt2L94bQTrA1eTH4zGV/Waspl19KOC1qemcY68o6XpWGDZwTkkZlEZBUZBzVqMLT7tFx89Db9iPne6UFl1OKMEWCM913NZRzhs/P3RxiTvJ8=
Message-ID: <21d7e9970511230307l1fcfc182w7ec82a76243a9a0c@mail.gmail.com>
Date: Wed, 23 Nov 2005 22:07:42 +1100
From: Dave Airlie <airlied@gmail.com>
To: Michael Frank <mhf@berlios.de>
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
Cc: Hugh Dickins <hugh@veritas.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Michael Krufky <mkrufky@m1k.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051122231603.2209814DA@hornet.berlios.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com>
	 <20051122211625.165F114CB@hornet.berlios.de>
	 <Pine.LNX.4.61.0511222124040.29784@goblin.wat.veritas.com>
	 <20051122231603.2209814DA@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Michael Frank <mhf@berlios.de> wrote:
> On Tuesday 22 November 2005 22:32, Hugh Dickins wrote:
> > On Tue, 22 Nov 2005, Michael Frank wrote:
> > > I am getting this also with i810 drm in Vanilla
> > > 2.6.15-rc2 upon exiting apps such as supertux.
> >
> > Aha, perhaps you're the one we've been waiting for.  I've
> > suspected a DRM issue, but nobody has actually seen one
> > until now, and I didn't want to put in a patch without
> > live justification.
> >
> > Would you please try the patch below, and let us know if
> > it fixes your problem.  If so, I'll send it off to Andrew
> > and Linus: the rest of the PageReserved fixes, including
> > the sound driver Bad page state fixes, have gone into
> > Linus' git tree today: perhaps this is the missing piece.
> >
> > If this does not work for you, then presumably you'd be
> > another sound driver sufferer?  and I should send you
> > that patch (or you pick it up from yesterday's LKML).
> > But right now I'd selfishly like you to test just this
> > DRM patch below.
> >
> > Thanks,
> > Hugh
>
> Your patch fixed the DRM issue.
>
> I also applied the patch (below) posted by you earlier to fix sound issues.
>

I'm at a bit of a loss how this can fix the i810 driver, but maybe I'm
missing something, I'm having a look at the drm_pci_alloc code that
calls pci_alloc_consistent, it may have an issue also (Hugh??)

I've queued up the patch for Linus, along with a couple of other bugfixes...

Dave.
