Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130951AbRA0TUx>; Sat, 27 Jan 2001 14:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbRA0TUn>; Sat, 27 Jan 2001 14:20:43 -0500
Received: from [63.95.87.168] ([63.95.87.168]:41990 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S130951AbRA0TUe>;
	Sat, 27 Jan 2001 14:20:34 -0500
Date: Sat, 27 Jan 2001 14:20:32 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Frank v Waveren <fvw@var.cx>
Cc: David Wagner <daw@cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127142032.E6821@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <14960.56461.296642.488513@pizda.ninka.net> <3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no> <94tho8$627$1@abraham.cs.berkeley.edu> <20010127191809.A3727@var.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010127191809.A3727@var.cx>; from fvw@var.cx on Sat, Jan 27, 2001 at 07:18:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 07:18:09PM +0100, Frank v Waveren wrote:
> On Sat, Jan 27, 2001 at 04:10:48AM +0000, David Wagner wrote:
> > Practice being really, really paranoid.  Think: You're designing a
> > firewall; you've got some reserved bits, currently unused; any future code
> > that uses them could behave in completely arbitrary and insecure ways,
> > for all you know.  Now recall that anything not known to be safe should
> > be denied (in a good firewall) -- see Cheswick and Bellovin for why.
> > When you take this point of view, it is completely understandable why
> > firewalls designed before ECN was introduced might block it.
> 
> Why? Why not just zero them, and get both security and compatibility...

Eeek! NO!!!! NO NO NO NO NO NO NO!
For ECN that would have worked, but that doesn't mean that something
couldn't have been implimented there that wouldn't have worked that way..

I think that older Checkpoint firewalls (perhaps current?) zeroed out SACK
on 'hide nat'ed connections. This causes unreasonable stalls for users on
SACK enabled clients. Not cool.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
