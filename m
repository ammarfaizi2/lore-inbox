Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbTEMNXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTEMNXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:23:35 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:56076 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261199AbTEMNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:23:34 -0400
Date: Tue, 13 May 2003 17:33:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: davidm@hpl.hp.com
Cc: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
Message-ID: <20030513173347.A25865@jurassic.park.msu.ru>
References: <16062.37308.611438.5934@napali.hpl.hp.com> <20030511195543.GA15528@suse.de> <1052690133.10752.176.camel@thor> <16063.60859.712283.537570@napali.hpl.hp.com> <1052768911.10752.268.camel@thor> <16064.453.497373.127754@napali.hpl.hp.com> <1052774487.10750.294.camel@thor> <16064.5964.342357.501507@napali.hpl.hp.com> <1052786080.10763.310.camel@thor> <16064.17852.647605.663544@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16064.17852.647605.663544@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, May 12, 2003 at 06:09:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 06:09:16PM -0700, David Mosberger wrote:
> OK, I believe the only other architecture that sets
> "cant_use_aperture" is Alpha.

Note that some Alphas may have "cant_use_aperture" cleared.
I mean Nautilus - unfortunate product of Athlon northbridge
and EV6 interbreeding... I've just managed to get agpgart working
to some degree on one of these beasts (UP1500), but with so many
ugly and fragile hacks that I'm not sure that I ever want
to submit this. ;-)

>  I asked some Alpha folks several months
> ago about my patch, but never got a conclusive answer.  IIRC, on Alpha
> the physical address itself determines cacheablity.  If so, we can use
> PAGE_KERNEL (which is universal) instead of PAGE_KERNEL_NOCACHE.

Yes.

> Clearly the patch needs to be tested on Alpha.  The upside is that it
> should let the Alpha folks get rid of a lot of ugliness in the
> ioremap() code.

That would be great. 
[Cc'd to Jeff, who wrote Alpha AGP code]

Ivan.
