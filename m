Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314312AbSDRLOh>; Thu, 18 Apr 2002 07:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314313AbSDRLOg>; Thu, 18 Apr 2002 07:14:36 -0400
Received: from ns.suse.de ([213.95.15.193]:6419 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314312AbSDRLOg>;
	Thu, 18 Apr 2002 07:14:36 -0400
Date: Thu, 18 Apr 2002 13:14:31 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, Doug Ledford <dledford@redhat.com>,
        jh@suse.cz, linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
        ak@suse.de, pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole
Message-ID: <20020418131431.B22558@wotan.suse.de>
In-Reply-To: <20020418072615.I14322@dualathlon.random> <E16y9vu-0004PJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 12:18:34PM +0100, Alan Cox wrote:
> > This mean the mmx isn't really backwards compatible and that's
> > potentially a problem for all the legacy x86 multiuser operative
> > systems.  That's an hardware design bug, not a software problem.  In
> > short running a 2.[02] kernel on a MMX capable CPU isn't secure, the
> > same potentially applies to windows NT and other unix, no matter of SSE.
> 
> That was my initial reaction but when I reread the documentation the 
> Intel folks are actually saying even back in Pentium MMX days that it isnt
> guaranteed that the FP/MMX state are not seperate registers

In this case it would be possible to only do the explicit clear
when the CPU does support sse1. For mmx only it shouldn't be needed.
For sse2 also not.


-Andi
