Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277904AbRJWQOz>; Tue, 23 Oct 2001 12:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277894AbRJWQOw>; Tue, 23 Oct 2001 12:14:52 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19725 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S277882AbRJWQOP>; Tue, 23 Oct 2001 12:14:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: VM
Date: Tue, 23 Oct 2001 18:15:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1337.1003815535@ocs3.intra.ocs.com.au>
In-Reply-To: <1337.1003815535@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011023161446Z16332-4006+621@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2001 07:38 am, Keith Owens wrote:
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> >If you want to argue for something, argue for giving config the ability to 
> >apply patches, that would be lots of fun.
> 
> It is kbuild rather than config that needs the ability.  I could do it
> trivially in kbuild 2.5, I almost added the facility at one time.  Alas
> it breaks when you get overlapping patches, select one config or
> another and it works, select both (assuming they are not exclusive) and
> it breaks.

Yes, if someone was determined to set this up they'd have to laboriously 
break up overlapping patches into common vs independent pieces, and determine 
that other patches are simply mutually incompatible, thus requiring suitable 
config rule restrictions.  Wow, way too much work for the tree owner, and 
things will re-break frequently when the patch owner makes updates.

Maybe this technique is something that would interest the FOLK guys, where 
the goal is to produce a single tree with as many options as possible, and 
where they're willing to put in extra maintainance work.  Besides the two VM 
designs, there's the XFS patch, which we don't have a good way of integrating 
into a single tree just yet.

Please treat the above as idle speculation.  It's evident that including 
patches in kbuild is an express route to madness.  For one thing, I'd no 
longer be able to index the complete source tree for browsing.

> I don't have a solution and the symptoms of overlapping patches are
> worse than the problem that patches are trying to fix, so I left patch
> support out of kbuild 2.5.  You can use shadow trees where you overlay
> a new implementation of a subsystem over the base kernel, then switch
> between versions by specifying which set of trees you are using.

--
Daniel
