Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292177AbSBBBUR>; Fri, 1 Feb 2002 20:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292178AbSBBBUH>; Fri, 1 Feb 2002 20:20:07 -0500
Received: from [24.71.103.168] ([24.71.103.168]:56837 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S292177AbSBBBT4>; Fri, 1 Feb 2002 20:19:56 -0500
X-Authentication: e09339aa9dc8042458104cebfcc348dc2522b403
Date: Fri, 1 Feb 2002 19:19:28 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Message-ID: <20020201191928.D2122@twoflower.internal.do>
In-Reply-To: <lm@bitmover.com> <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de> <20020201083855.C8664@work.bitmover.com> <20020202001058.UXDU10685.femail14.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020202001058.UXDU10685.femail14.sdc1.sfba.home.com@there>; from landley@trommello.org on Fri, Feb 01, 2002 at 06:45:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> wrote:
> 
> The problem is, if they use bitkeeper (with a temporary respository), all 
> these temporary commits (debugging tries saved in case they want to roll back 
> during development) get propagated into the main repository when they do a 
> merge.  They can't tell it "done, okay, squash this into one atomic change to 
> check in somewhere else, with the whole change history as maybe one comment".

Something like:

  bk start-temporary-fork
  [hack hack hack]
  bk commit
  [hack hack hack]
  bk revert 
  [hack hack hack]
  bk commit 
  [hack hack hack]
  bk commit
  bk fold-back-into-main-tree-as-one-atomic-update

?

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
