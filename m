Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318904AbSHEWMg>; Mon, 5 Aug 2002 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318905AbSHEWMg>; Mon, 5 Aug 2002 18:12:36 -0400
Received: from ns.suse.de ([213.95.15.193]:22020 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318904AbSHEWMf>;
	Mon, 5 Aug 2002 18:12:35 -0400
Date: Tue, 6 Aug 2002 00:16:05 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user  mode linux]
Message-ID: <20020806001605.B18891@wotan.suse.de>
References: <20020805163910.C7130@kushida.apsleyroad.org.suse.lists.linux.kernel> <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com.suse.lists.linux.kernel> <p73znw1i781.fsf@oldwotan.suse.de> <20020805223006.A8773@kushida.apsleyroad.org> <20020805233542.A12753@wotan.suse.de> <20020805230941.A8816@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020805230941.A8816@kushida.apsleyroad.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 11:09:41PM +0100, Jamie Lokier wrote:
> Andi Kleen wrote:
> > > 2: What happens when the user's signal handler decides it wants to save
> > > the FPU state itself (after all) and proceed with some FPU use.  Will
> > > sigreturn restore the user-saved FPU state?  Just curious.
> > 
> > Nope it won't because there is no saved state. The previous context's FPU 
> > state will be silently corrupted.
> 
> I meant if the user's signal handler decides it wants to save the FPU
> state directly into the signal context struct, after deciding to do
> that.  Won't that work?

In theory yes. The space should be already allocated on the stack, it just
has to be filled in.

-Andi
