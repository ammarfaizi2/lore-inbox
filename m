Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318902AbSHEWGR>; Mon, 5 Aug 2002 18:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318903AbSHEWGP>; Mon, 5 Aug 2002 18:06:15 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:28330 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318902AbSHEWGO>; Mon, 5 Aug 2002 18:06:14 -0400
Date: Mon, 5 Aug 2002 23:09:41 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user  mode linux]
Message-ID: <20020805230941.A8816@kushida.apsleyroad.org>
References: <20020805163910.C7130@kushida.apsleyroad.org.suse.lists.linux.kernel> <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com.suse.lists.linux.kernel> <p73znw1i781.fsf@oldwotan.suse.de> <20020805223006.A8773@kushida.apsleyroad.org> <20020805233542.A12753@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020805233542.A12753@wotan.suse.de>; from ak@suse.de on Mon, Aug 05, 2002 at 11:35:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > 2: What happens when the user's signal handler decides it wants to save
> > the FPU state itself (after all) and proceed with some FPU use.  Will
> > sigreturn restore the user-saved FPU state?  Just curious.
> 
> Nope it won't because there is no saved state. The previous context's FPU 
> state will be silently corrupted.

I meant if the user's signal handler decides it wants to save the FPU
state directly into the signal context struct, after deciding to do
that.  Won't that work?

-- Jamie
