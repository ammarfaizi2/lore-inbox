Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSJaBgs>; Wed, 30 Oct 2002 20:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSJaBgs>; Wed, 30 Oct 2002 20:36:48 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:37905 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265097AbSJaBgr>; Wed, 30 Oct 2002 20:36:47 -0500
Message-ID: <3DC08A9C.F5B267A8@zk3.dec.com>
Date: Wed, 30 Oct 2002 20:42:52 -0500
From: Peter Rival <frival@zk3.dec.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
Cc: Anton Blanchard <anton@samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] use asm-generic/topology.h
References: <3DC056C2.4070609@us.ibm.com> <20021030233107.GB4820@krispykreme> <3DC06CAE.8040806@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:

> Anton Blanchard wrote:
> > Hi Matt,
> >
> >
> >>use_generic_topology.patch
> >>
> >>This patch changes ppc64 & alpha to use the generic topology.h for the
> >>non-NUMA case rather than redefining the same macros.  It is much easier
> >>to maintain one set of generic non-NUMA macros than several.
> >
> >
> > Looks good from the ppc64 perspective.
> >
> > Anton
>
> Glad to have the positive feedback.  It doesn't really change how
> anything works, just eliminates duplicate code and makes modifying the
> generic behavior simpler.
>
> Anyone that works with alpha want to verify that I haven't inadvertently
> hosed your topology file?
>

I'd say six of one, half-dozen of the other.  I've been working with another
engineer on updated patches that among other things make NUMA work on Alpha
again.  We're also re-working much of the surrounding code, including much of
this file anyway - Marvel uses a much different topology than Wildfire.

It looks fine to me, but realistically the only opinion I can give for real is
a shoulder shrug, as I'm not exactly sure when the code will be ready for
submission.  Actually, the patch looks just like a part of the patch we have
working, just without Marvel support.  Then again, I suppose IBM would have a
hard time doing that, huh? ;)

 - Pete

