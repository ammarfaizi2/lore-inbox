Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSKTUPf>; Wed, 20 Nov 2002 15:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSKTUPf>; Wed, 20 Nov 2002 15:15:35 -0500
Received: from trillium-hollow.org ([209.180.166.89]:34489 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S262324AbSKTUPc>; Wed, 20 Nov 2002 15:15:32 -0500
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x 
In-Reply-To: Your message of "Wed, 20 Nov 2002 21:03:57 +0100."
             <20021120210357.70464ff2.skraw@ithnet.com> 
Date: Wed, 20 Nov 2002 12:22:31 -0800
From: erich@uruk.org
Message-Id: <E18EbMm-0003b1-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephan von Krawczynski <skraw@ithnet.com> wrote:

> On Tue, 19 Nov 2002 12:08:34 +0000
> Dave Jones <davej@codemonkey.org.uk> wrote:
> 
> > On Mon, Nov 18, 2002 at 09:54:52PM +0100, Ricardo Galli wrote:
> > 
> >  > It's very cosmetic but very annoying for P3 > 1GHz, where Linux <= 2.4.20-
> preX 
> >  > only reports 32 KB of cache and it also seems to ignore the "cachesize" 
> >  > parameter. Perhaps it really uses 256KB, but not sure.
> > 
> > There was a bug related to that parameter, I'm sure if the fix
> > went into the same patch, or a separate one. I'll check later.
> 
> Sorry for this possibly dumb comment/question:
> my Tualatins have 512KB cache on die. Are we all sure that it's used?
> /proc says indeed 32KB on 2.4.20-rc2

On x86 systems in general the full cache sizes are always used.  It's
enabled in the hardware/BIOS, so there should be no problem there.

The only thing it might do is change any optimizations the Linux kernel
is trying to make to optimize for the cache size.  The only one I'm
aware of at the moment is the weighting algorithm when running in SMP
(i.e. how hard to fix a process to a particular processor in order to
take best advantage of the cache footprint).

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
