Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136606AbREGS5V>; Mon, 7 May 2001 14:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136611AbREGS5O>; Mon, 7 May 2001 14:57:14 -0400
Received: from bitmover.com ([207.181.251.162]:4938 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136606AbREGS5A>;
	Mon, 7 May 2001 14:57:00 -0400
Date: Mon, 7 May 2001 11:56:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010507115659.T14127@work.bitmover.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com> <9d6qk6$i86$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <9d6qk6$i86$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 11:47:34AM -0700, H. Peter Anvin wrote:
> Followup to:  <20010505194536.D14127@work.bitmover.com>
> By author:    Larry McVoy <lm@bitmover.com>
> In newsgroup: linux.dev.kernel
> >
> > On Sun, May 06, 2001 at 02:20:43PM +1200, Chris Wedgwood wrote:
> > > 1.5GB without ECC? Seems like a disater waiting to happen? Is ECC
> > > memory much more expensive?
> > 
> > Almost twice as expensive for 512MB dimms.
> > 
> > I used to be a die hard ECC fan but that changed since what we do here is
> > BitKeeper and BitKeeper checksums everything.  It tells us right away when
> > we have problems (to date it has found bad memory dimms, NFS corruption,
> > and a SPARC/Linux cache aliasing bug).  So I've given up in ECC, we don't
> > need it.
> > 
> > On the other hand, if your apps don't have built in integrity checks then
> > ECC is pretty much a requirement.
> 
> Isn't this pretty much saying "if you're willing to dedicate your
> system to running nothing but Bitkeeper, you can run it really fast?"

A) Fast has nothing to do with it, ECC runs at the same speed as non-ECC;
B) As I said above, "if your apps don't have built in integrity checks then
   ECC is pretty much a requirement";
C) As I said above, we use our systems for BK development, so this choice
   makes sense for us.

I think the point you are really missing is that it is not an either/or
choice.  All you really need in practice is one application which is
both heavily used and has integrity checks.  It could be BitKeeper or
something else, all that matters is that it will detect memory problems.

That application will flush out your memory problems.  Yeah, you could
get burned before that app finds them and if you are worried about that,
then run ECC.  I think it's an interesting data point, however, that I
care deeply about data integrity and I've transitioned from insisting 
on ECC to not caring.  If my choice wasn't working for me, I would 
still be using ECC.  In other words, I'm a lot closer to your way of
thinking than you might expect.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
