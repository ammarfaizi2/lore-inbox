Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSBBFvB>; Sat, 2 Feb 2002 00:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292232AbSBBFuv>; Sat, 2 Feb 2002 00:50:51 -0500
Received: from bitmover.com ([192.132.92.2]:24194 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292231AbSBBFul>;
	Sat, 2 Feb 2002 00:50:41 -0500
Date: Fri, 1 Feb 2002 21:50:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Charles Cazabon <linux-kernel@discworld.dyndns.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Message-ID: <20020201215040.F27081@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Charles Cazabon <linux-kernel@discworld.dyndns.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <lm@bitmover.com> <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de> <20020201083855.C8664@work.bitmover.com> <20020202001058.UXDU10685.femail14.sdc1.sfba.home.com@there> <20020201191928.D2122@twoflower.internal.do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201191928.D2122@twoflower.internal.do>; from linux-kernel@discworld.dyndns.org on Fri, Feb 01, 2002 at 07:19:28PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 07:19:28PM -0600, Charles Cazabon wrote:
> Rob Landley <landley@trommello.org> wrote:
> > 
> > The problem is, if they use bitkeeper (with a temporary respository), all 
> > these temporary commits (debugging tries saved in case they want to roll back 
> > during development) get propagated into the main repository when they do a 
> > merge.  They can't tell it "done, okay, squash this into one atomic change to 
> > check in somewhere else, with the whole change history as maybe one comment".
> 
> Something like:
> 
>   bk start-temporary-fork

    bk clone main temporary-fork

>   [hack hack hack]
>   bk commit
>   [hack hack hack]
>   bk revert 

    bk fix -c

>   [hack hack hack]
>   bk commit 
>   [hack hack hack]
>   bk commit
>   bk fold-back-into-main-tree-as-one-atomic-update

    bk push

All exists, works as described, no changes necessary.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
