Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRAVGh5>; Mon, 22 Jan 2001 01:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130352AbRAVGhs>; Mon, 22 Jan 2001 01:37:48 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:41734 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130194AbRAVGhg>; Mon, 22 Jan 2001 01:37:36 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Bernd Eckenfels <inka-user@lina.inka.de>
Date: Mon, 22 Jan 2001 17:37:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14955.54550.722226.199371@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
In-Reply-To: message from Bernd Eckenfels on Monday January 22
In-Reply-To: <E14KUgh-0000kk-00@sites.inka.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 22, inka-user@lina.inka.de wrote:
> In article <14955.19182.663691.194031@notabene.cse.unsw.edu.au> you wrote:
> > There have been assorted reports of filesystem corruption on raid5 in
> > 2.4.0, and I have finally got a patch - see below.
> > I don't know if it addresses everybody's problems, but it fixed a very
> > really problem that is very reproducable.
> 
> Do you know if it is safe with 2.4.0 kernels to swap on degraded soft raids?
> On the debian-devel list there is a discussion. Currently Debisn Systems to
> not do swap-on on boot if a raid partition is resyncing.

In 2.2 it was not safe to swap to a RAID array that we being resyched
or was having a spare reconstructed, but in 2.4 it is perfectly safe.

It would be entirely appropriate for the init.d script to check for
version >= 2.3.9pre8 (I think that is when the new resync code went
it) - or probably just >= 2.4.0, and bypass any fancy checks if that
is the case.

NeilBrown


> 
> Greetings
> Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
