Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274918AbTHLAQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 20:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274920AbTHLAQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 20:16:52 -0400
Received: from holomorphy.com ([66.224.33.161]:63403 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S274918AbTHLAQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 20:16:51 -0400
Date: Mon, 11 Aug 2003 17:17:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Timothy Miller <miller@techsource.com>
Cc: rob@landley.net, Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-ID: <20030812001759.GS1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Timothy Miller <miller@techsource.com>, rob@landley.net,
	Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
	linux-kernel@vger.kernel.org, kernel@kolivas.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com> <200308110414.28569.rob@landley.net> <3F382B8B.9000301@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F382B8B.9000301@techsource.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
>> Another way of looking at it is that every time you remove a bottleneck, 
>> the next most serious problem becomes the new bottleneck.
>> Does this mean it's a bad idea to stop trying to identify the next 
>> bottleneck?  (Whether or not you then choose to deal with it is another 
>> question...)

On Mon, Aug 11, 2003 at 07:49:31PM -0400, Timothy Miller wrote:
> No.  It just means that it's possible to produce artificial loads that 
> break things, and since those artificial loads won't be encountered in 
> typical usage, they should not be optimized for.
> Mind you, we prefer that the worst case "record you cannot play" doesn't 
> have TOO much impact, because we don't want people writing DoS programs 
> which exploit those artificial cases.

Guys, it's _way_ premature to say any of this. AFAICT _no_ alternatives
to the duelling queues with twiddled priorities have been explored yet,
nor has the maximum been squeezed out of twiddling the methods for
priority adjustment in that yet (which is Con Kolivas' area).


-- wli
