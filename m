Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280402AbRK1TeM>; Wed, 28 Nov 2001 14:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280365AbRK1TeB>; Wed, 28 Nov 2001 14:34:01 -0500
Received: from [128.165.17.254] ([128.165.17.254]:48336 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S280402AbRK1Tdq>; Wed, 28 Nov 2001 14:33:46 -0500
Date: Wed, 28 Nov 2001 12:33:41 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Lars Brinkhoff <lars.spam@nocrew.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Magic Lantern
Message-ID: <20011128123341.K22767@lanl.gov>
In-Reply-To: <Pine.LNX.3.95.1011128090654.10732B-100000@chaos.analogic.com> <20011128081305.I22767@lanl.gov> <85oflmvi8g.fsf@junk.nocrew.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85oflmvi8g.fsf@junk.nocrew.org>
User-Agent: Mutt/1.3.18i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 07:54:39PM +0100, Lars Brinkhoff wrote:
> Eric Weigle <ehw@lanl.gov> writes:
> > > > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > > > > Basically, a "tee" to capture all network packets and pass them
> > > > > on to a filtering task without affecting normal network activity.
> > > > The af_packet module can read and write raw ethernet frames.
> > The af_packet module may also be fairly inefficient. If you need
> > performance over, say, a gigabit link, you may have trouble.
> 
> Are you (or anyone else) aware of any alternative?
I'm sure it's just something silly that's hurt the performance of the
af_packet module (perhaps already fixed, perhaps in my methodology :|)

For the purposes of the work I was doing here (totally unrelated to this
Magic Lantern BS, which I didn't even know what it was until after I posted
the first response in this thread), I just needed to saturate a gigE link for
testing. To do this I just used three boxes flooding UDP packets and that
worked. As far as traffic collection goes (which is what I was testing),
we went with another approach-- an optical tap to snarf off a copy of all
the data on a link, and then a custom kernel I hacked up to do the work
in the kernel itself (avoiding the kernel--user space copy and the stack
entirely). This is not for the faint of heart.


-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
