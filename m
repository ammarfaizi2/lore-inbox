Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSJAK6o>; Tue, 1 Oct 2002 06:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbSJAK6o>; Tue, 1 Oct 2002 06:58:44 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:28137 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261558AbSJAK6m>;
	Tue, 1 Oct 2002 06:58:42 -0400
Date: Tue, 1 Oct 2002 12:06:28 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: CPU/cache detection wrong
Message-ID: <20021001110628.GA17865@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alexander Hoogerhuis <alexh@ihatent.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
References: <m3hegaxpp0.fsf@lapper.ihatent.com> <1033403655.16933.20.camel@irongate.swansea.linux.org.uk> <m3wup3bcgb.fsf@lapper.ihatent.com> <20020930221536.GA6987@suse.de> <m3smzqipzd.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3smzqipzd.fsf@lapper.ihatent.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 09:21:26AM +0200, Alexander Hoogerhuis wrote:
 > Dave Jones <davej@codemonkey.org.uk> writes:
 > 
 > > On Mon, Sep 30, 2002 at 07:43:16PM +0200, Alexander Hoogerhuis wrote:
 > > 
 > >  > PU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
 > >  > Cache info byte: 50
 > > 
 > > Instruction TLB (ignored)
 > > 
 > >  > Cache info byte: 5B
 > > 
 > > Data TLB (ignored)
 > > 
 > >  > Cache info byte: 66
 > > 
 > > 8K L1 data cache
 > >  
 > >  > Cache info byte: 00
 > >  > Cache info byte: 00
 > >  > Cache info byte: 00
 > >  > Cache info byte: 00
 > >  > Cache info byte: 00
 > >  > Cache info byte: 00
 > >  > Cache info byte: 00
 > >  > Cache info byte: 00
 > > 
 > > Null
 > >  
 > >  > Cache info byte: 40
 > > 
 > > No 3rd level cache.
 > > 
 > >  > Cache info byte: 70
 > > 
 > > 12K-uops trace cache
 > > 
 > >  > Cache info byte: 7B
 > > 
 > > 512K L2 cache
 > > 
 > >  > Cache info byte: 00
 > > 
 > > Null.
 > >  
 > >  > CPU: L1 I cache: 0K, L1 D cache: 8K
 > >  > CPU: L2 cache: 512K
 > > 
 > 
 > Here we go:
 > 
 > CPU: Trace cache: 12K uops, L1 D cache: 8K
 > CPU: L2 cache: 512K
 > 
 > But my BIOS still say I should have 8Kb/8Kb I/D L1 cache... oh
 > well. I'm sure Alan Cox would just write it up as marketing, since
 > thats about how reliable a BIOS is :)

Hmm, can a P4 have a trace cache AND an L1 I cache ?
I thought they were exclusive, which is why the code
doesn't take this into account. Easily fixed if so though..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
