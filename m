Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280819AbRKBUcv>; Fri, 2 Nov 2001 15:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280820AbRKBUcl>; Fri, 2 Nov 2001 15:32:41 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:29705 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280819AbRKBUcY>; Fri, 2 Nov 2001 15:32:24 -0500
Date: Fri, 2 Nov 2001 22:32:09 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: John Adams <johna@onevista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
Message-ID: <20011102223209.D26218@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX> <01110215041301.01066@flash>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01110215041301.01066@flash>; from johna@onevista.com on Fri, Nov 02, 2001 at 04:04:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 04:04:13PM -0400, you [John Adams] claimed:
> > >
> > > $ exec 3>&1; find / -name "wanted-but-lost-download" 2>&1 1>&3 3>&- |
> > > eat
> > >
> > > [stolen from "Csh Programming Considered Harmful" by Tom Christiansen]
> > >
> > > Horrible, but does work.  ;)
> 
> You really do take the hard way.  Try this to pipe just stderr:
> command_that_outputs_on_1_and_2   2>/dev/stdout 1>/dev/null | eat

Hmm.

The initial question was how to do

find / -name foo 2> /dev/null 

or similar if /dev/null is not present. (Eat is a place holder for a
imaginary progrom acting as /dev/null replacement).

I guess 

find / -name foo 2>/dev/stdout 1>/dev/stderr | eat

would (kinda) work, but it fails if you want to do

find / -name foo 2> /dev/null | less

Can be done with named pipes, though.


-- v --

v@iki.fi
