Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135302AbRA0UOo>; Sat, 27 Jan 2001 15:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135369AbRA0UOe>; Sat, 27 Jan 2001 15:14:34 -0500
Received: from [63.95.87.168] ([63.95.87.168]:57862 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S135302AbRA0UO3>;
	Sat, 27 Jan 2001 15:14:29 -0500
Date: Sat, 27 Jan 2001 15:14:28 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Frank v Waveren <fvw@var.cx>, David Wagner <daw@cs.berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127151428.H6821@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <14960.56461.296642.488513@pizda.ninka.net> <3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no> <94tho8$627$1@abraham.cs.berkeley.edu> <20010127191809.A3727@var.cx> <20010127142032.E6821@xi.linuxpower.cx> <20010127205851.B2501@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010127205851.B2501@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Sat, Jan 27, 2001 at 08:58:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 08:58:51PM +0100, Jamie Lokier wrote:
[snip]
> > I think that older Checkpoint firewalls (perhaps current?) zeroed out SACK
> > on 'hide nat'ed connections. This causes unreasonable stalls for users on
> > SACK enabled clients. Not cool.
> 
> If both SACK and SACK_PERMITTED were zeroed out, the clients would
> negotiate non-SACK connections and everythings ok.  A performance
> disadvantage relative to allowing SACK, but that's true of ECN as well.

Some checkpoint firewalls have caused stalls on SACK enabled clients. I
don't recall the exact configuration or method of action, but it does
happen. I suspect that it didn't kill the SackOK but only the actual SACKs
data. 

Breaking end-to-end is the path to maddness. Trusting practically any
network that leaves a room is insane.

Firewalling should be implemented on the hosts, perhaps with centralized
policy management. In such a situation, there would be no reason to filter
on funny IP options.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
