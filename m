Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSLLRk1>; Thu, 12 Dec 2002 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSLLRk1>; Thu, 12 Dec 2002 12:40:27 -0500
Received: from mxintern.kundenserver.de ([212.227.126.204]:37111 "EHLO
	mxintern.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264976AbSLLRk0>; Thu, 12 Dec 2002 12:40:26 -0500
Date: Thu, 12 Dec 2002 18:48:14 +0100
From: Anders Henke <anders.henke@sysiphus.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using 2 TB  in real life
Message-ID: <20021212174814.GA18993@schlund.de>
References: <20021212111237.GA12143@schlund.de> <029301c2a1d6$85cbe280$f6de11cc@black> <1039713776.16887.4.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039713776.16887.4.camel@camp4.serpentine.com>
User-Agent: Mutt/1.3.28i
Organization: Schlund + Partner AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 12th 2002, Bryan O'Sullivan wrote:
> On Thu, 2002-12-12 at 04:03, Mike Black wrote:
> > Looks like it's already handled in 2.5.
> > Here's a patch for 2.4:
> > http://www.gelato.unsw.edu.au/patches-index.html
> 
> The result of the device size calculation that Anders complained about
> in 2.4.20 was wrong in a different way in Peter's >2TB patch, last I
> looked.  I don't think Peter's patch is necessary for a 1.9TB device,
> anyway.

Peter's patch is not necessary for a 1.9TB device, but (from a quick
glance at the source) should fix the display problem I mentioned.


Personally I've no problem using 2.4.20 without this patch applied,
although sd.c makes 1.9TB devices look as being something coming
from a very dark corner of the universe ...

I knew of the 2 TB limit before, but the strange output brought me
to extensively test both xfs and ext3 on it before writing any
important data on the device. Other people might assume that Linux simply
cannot handle (scsi/fc) devices larger than 0.5 TB or think Linux of
being of less quality than $other_operating_system ("they claim 2 TB is 
the limit, but it somehow chokes at only 0.5 TB").

It would be a very kind thing if someone knows how to fix sd.c that
way would do it before such ideas arise - unluckily, I don't have the
in-depth knowledge to do this, so I'm sending this as a notice to 
linux-kernel (as this is the place where I believe the ones are who
know how to do fix it).


Regards,

Anders
-- 
http://sysiphus.de/
