Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbTAGGZK>; Tue, 7 Jan 2003 01:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTAGGZK>; Tue, 7 Jan 2003 01:25:10 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:61388 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267312AbTAGGY1>; Tue, 7 Jan 2003 01:24:27 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Aaron Lehmann <aaronl@vitelus.com>
Date: Tue, 7 Jan 2003 17:07:06 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15898.28298.486412.214548@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an arbitraty piece of memory.
In-Reply-To: message from Aaron Lehmann on Monday January 6
References: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
	<20030107053152.GF26827@vitelus.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 6, aaronl@vitelus.com wrote:
> On Tue, Jan 07, 2003 at 04:03:28PM +1100, Neil Brown wrote:
> > I did a little testing and found that on a list of 2 million 
> > basenames from a recent backup index (800,000 unique):
> > 
> >  hash_mem (as included here) is noticably faster than HASH_HALF_MD4 or
> >  HASH_TEA: 
> > 
> >   hash_mem:		10 seconds
> >   DX_HASH_HALF_MD4:	14 seconds
> >   DX_HASH_TEA:		15.2 seconds
> 
> I'm curious how the hash at
> http://www.burtleburtle.net/bob/hash/doobs.html would fare. He has a
> 64-bit version at
> http://www.burtleburtle.net/bob/c/lookup8.c.

Performing the same tests: producing 8 bit hashes from 800,000
filenames.

Speed is 10 seconds, comarable to hash_mem

normalised standard deviation of frequencies is 0.0171039
which is is the same ball park as the hashes ext3 uses
(they gave 0.0169 and 0.0182.  hash_mem gave 0.02255).

So (on this set of values at least) it does seem to be a better hash
function. 

I might look more closely at it.

Thanks,
NeilBrown
