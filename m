Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318536AbSHPQYP>; Fri, 16 Aug 2002 12:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSHPQYP>; Fri, 16 Aug 2002 12:24:15 -0400
Received: from waste.org ([209.173.204.2]:29655 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318536AbSHPQYO>;
	Fri, 16 Aug 2002 12:24:14 -0400
Date: Fri, 16 Aug 2002 11:28:02 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: henrique <henrique@cyclades.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
Message-ID: <20020816162802.GF5418@waste.org>
References: <200208151514.51462.henrique@cyclades.com> <20020815182556.GV9642@clusterfs.com> <20020815190336.GN22974@opus.bloom.county> <20020815195933.GW9642@clusterfs.com> <20020815210449.GA26993@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815210449.GA26993@opus.bloom.county>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 02:04:49PM -0700, Tom Rini wrote:
> On Thu, Aug 15, 2002 at 01:59:33PM -0600, Andreas Dilger wrote:
> > On Aug 15, 2002  12:03 -0700, Tom Rini wrote:
> > > On Thu, Aug 15, 2002 at 12:25:56PM -0600, Andreas Dilger wrote:
> > > > Maybe the PPC keyboard/mouse drivers do not add randomness?
> > > 
> > > Well, how is this set for the i386 ones?  I grepped around and I didn't
> > > really see anything, so I'm sort-of confused.
> > 
> > I think it is something like "add_mouse_entropy" and "add_keyboard_entropy"
> > or similar.  If you look at the random.c sources you can find the actual
> > function names and work backwards from there.
> 
> Ah, thanks.  In that case, no.  It doesn't look like the input-layer USB
> keyboards contribute to entropy (but mice do), and I don't think the ADB
> ones do.  I'll take a crack at adding this to keyboards monday maybe.

Tom, I'm working on a set of patches that completely change this
interface because there are a bunch of problems with the current
entropy accounting.

What PPC and other arches really need in this area is a higher
resolution timing source. The jiffies-based timing is rather
limiting, especially after the entropy accounting stops overestimating
things by orders of magnitude. Does the PPC port have a convenient way
to access the TBR or something similar?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
