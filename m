Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424123AbWKPOtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424123AbWKPOtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424122AbWKPOtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:49:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29583 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424115AbWKPOti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:49:38 -0500
Subject: Re: [Madwifi-devel] ANNOUNCE: SFLC helps developers assess ar5k
	(enabling free Atheros HAL)
From: Dan Williams <dcbw@redhat.com>
To: Pavel Roskin <proski@gnu.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       madwifi-devel@lists.sourceforge.net, lwn@lwn.net
In-Reply-To: <1163619541.19111.6.camel@dv>
References: <20061115031025.GH3451@tuxdriver.com>
	 <200611151942.14596.mb@bu3sch.de>  <20061115192054.GA10009@tuxdriver.com>
	 <1163619541.19111.6.camel@dv>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 09:50:55 -0500
Message-Id: <1163688655.2585.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 14:39 -0500, Pavel Roskin wrote:
> Hello!
> 
> On Wed, 2006-11-15 at 14:21 -0500, John W. Linville wrote:
> > On Wed, Nov 15, 2006 at 07:42:14PM +0100, Michael Buesch wrote:
> > 
> > > Now that it seems to be ok to use these openbsd sources, should I port
> > > them to my driver framework?
> > > I looked over the ar5k code and, well, I don't like it. ;)
> > > I don't really like having a HAL. I'd rather prefer a "real" driver
> > > without that HAL obfuscation.
> > 
> > I don't think anyone likes the HAL-based architecture.  I don't think
> > we will accept a HAL-based driver into the upstream kernel.
> 
> I said it before, and it's worth repeating.  Dissolving HAL in the
> sources is easy.  It's just a matter of moving functions around without
> serious chances of breaking anything as long as the source compiles.
> The whole "HAL-based architecture" can be reshuffled and eliminated by
> one person in a few days.
> 
> Making things work properly takes years.  That's what MadWifi has been
> working on for a long time, using contributions and bug reports from
> scores of users and developers.
> 
> Rejecting MadWifi because it's HAL based is like throwing away a diamond
> ring because it's too narrow.

No, I'd personally reject madwifi not because of the HAL but because it
uses the net80211 stack [1].  We don't need another 802.11 stack in the
Linux kernel, of course.  But since the Devicescape people have already
ported madwifi to d80211 (see David Kimdon's announcement on netdev on
Oct. 17th), that appears to be a valid path to follow and at least some
of the work has already been done.  If the HAL bits were ported to ar5k
and folded back into the driver, I think that would be a great start.

Dan

[1] nothing against net80211; it's a fine stack.  But There Can Be Only
One, if just for sanity's sake.

