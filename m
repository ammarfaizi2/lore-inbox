Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVKEA61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVKEA61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbVKEA61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:58:27 -0500
Received: from dsl081-059-088.sfo1.dsl.speakeasy.net ([64.81.59.88]:38100 "EHLO
	piratehaven.org") by vger.kernel.org with ESMTP id S1751393AbVKEA60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:58:26 -0500
Date: Fri, 4 Nov 2005 16:58:25 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: Patrick McHardy <kaber@trash.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
       kaber@coreworks.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
Message-ID: <20051105005825.GA942@skull.piratehaven.org>
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436BFE08.6030906@trash.net>
User-Agent: Mutt/1.4.2.1i
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 01:34:16AM +0100, Patrick McHardy wrote:
> 
> You assume all addresses following the primary addresses are secondary
> addresses of the primary, which is not true with multiple primaries.
> This patch (untested) makes sure only to send notification for real
> secondaries of the deleted address. It also removes a racy double-
> check for IN_DEV_PROMOTE_SECONDARIES - once we've decided to promote
> an address checking again opens a window in which address promotion
> could be disabled and we end up with only secondaries without a
> primary address.
> 

Yeah, I was wondering if there could be primaries after the
secondaries.  I'm pretty unfamiliar with this code (first looked at it
last week) and still don't have a handle on how the primaries
interact with the secondaries in the route lookup.  Which means it's
not clear to me why this was failing to begin with. :)

Your patch works for all of the cases I've been testing with so it
looks good to go from here.


BAPper
