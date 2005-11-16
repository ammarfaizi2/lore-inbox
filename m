Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbVKPTVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbVKPTVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVKPTVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:21:12 -0500
Received: from dsl081-059-088.sfo1.dsl.speakeasy.net ([64.81.59.88]:36843 "EHLO
	piratehaven.org") by vger.kernel.org with ESMTP id S1030441AbVKPTVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:21:10 -0500
Date: Wed, 16 Nov 2005 11:21:09 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org, davem@davemloft.net,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, jmorris@namei.org,
       yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
Message-ID: <20051116192109.GA23233@skull.piratehaven.org>
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net> <20051105010740.GR23537@postel.suug.ch> <436C090D.5020201@trash.net> <436C34F8.3090903@trash.net> <20051105134636.GS23537@postel.suug.ch> <20051107215022.GH23537@postel.suug.ch> <4370B203.8070501@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370B203.8070501@trash.net>
User-Agent: Mutt/1.4.2.1i
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 03:11:15PM +0100, Patrick McHardy wrote:
> 
> Yes, fixing it correctly looks very hard. Just changing the routes
> doesn't seem right to me, someone might have added it with exactly
> this prefsrc and doesn't want it to change, its also not clear how
> to notify on this. Taking care of correct ordering of the ifa_list
> is also more complicated without just deleting and readding them.
> 
> I have a patch to do this, but it needs some debugging, for some
> unknown reason it crashes sometimes if I remove addresses without
> specifying the mask.

Looks like I'm back on this one because just sending the NETDEV_UP for
the secondaries didn't work if a primary other than the first one is
removed.  If you have anything that you need help testing/debugging,
I'm stuck with this until it is fixed.  I'd prefer not to duplicate
effort on this if you're close to a fix.  If not, then I'll try to
come up with something and toss it out for comment.


BAPper
