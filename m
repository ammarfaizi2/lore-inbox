Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265059AbSJRHdr>; Fri, 18 Oct 2002 03:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265060AbSJRHdr>; Fri, 18 Oct 2002 03:33:47 -0400
Received: from tml.hut.fi ([130.233.44.1]:28688 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S265059AbSJRHdq>;
	Fri, 18 Oct 2002 03:33:46 -0400
Date: Fri, 18 Oct 2002 10:39:17 +0300
From: Antti Tuominen <ajtuomin@morphine.tml.hut.fi>
To: Pekka Savola <pekkas@netcore.fi>
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, yoshfuji@wide.ad.jp,
       torvalds@transmeta.com, jagana@us.ibm.com
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
Message-ID: <20021018073917.GA19020@morphine.tml.hut.fi>
References: <20021017162624.GC16370@morphine.tml.hut.fi> <Pine.LNX.4.44.0210172309160.28084-100000@netcore.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210172309160.28084-100000@netcore.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 11:14:32PM +0300, Pekka Savola wrote:
> On Thu, 17 Oct 2002, Antti Tuominen wrote:
> > Intermediate revision of the specification "Draft 18++" appeared a few
> > days ago, which addressed most of the issues with earlier drafts (16,
>
> Sounds great.  Hopefully it slows down a bit from being a moving target.

I heard Draft 19 should be out next week, so that should consolidate
the MIPv6 effort even further.

>  1) current tunneling (including sanity checks which are, I believe, a bit
> non-existant at the moment) should be generalized to handle v6-in-v6 and
> v6-in-v4 tunneling anyway.  Not sure if this is the right way, but that's
> IMO one priority item.

I'm sure we can improve the v6-in-v6 tunnel.  We had some discussion
with USAGI people about doing anything-in-v6 general tunnel, but since
that is somewhat beyond our project scope, v6-in-v6 is all we can
offer at this time.  I don't know about the USAGI folks' status on
this.

>  2) without IPSEC, there is no way to secure MN-HA traffic.  Therefore I 
> think the first priority is being able to support Correspondent Node 
> behaviour.

Right.  We've had our own IPSec AH support in all the previous
releases, but as everyone probably knows the USAGI guys have
implemented IPv6 IPSec.  This is why we dropped the IPSec stuff in our
code.  There is no point doing the same work again.  If (or when)
USAGI IPSec gets accepted to the kernel, we will be sure to modify our
code to support it.

> Having IPSEC + MIPv6 in 2.6 series would be Really Cool, though :-)

This is something we're hoping for too.

Regards,

Antti

-- 
Antti J. Tuominen, Gyldenintie 8A 11, 00200 Helsinki, Finland.
Research assistant, Institute of Digital Communications at HUT
work: ajtuomin@tml.hut.fi; home: tuominen@iki.fi

