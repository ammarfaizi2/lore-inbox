Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWJDT3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWJDT3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWJDT3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:29:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750884AbWJDT3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:29:32 -0400
Date: Wed, 4 Oct 2006 12:21:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061004185903.GA4386@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
References: <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
 <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
 <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
 <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
 <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
 <20061004185903.GA4386@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
> > 
> > It's not what we have ever done. We've _extended_ the API. But we don't 
> > break old ones.
> 
> 	Old APIs get deprecated, and people are forced to the new API,
> which is exactly the same as far as userspace is concerned. This
> transition is exactly the same as what you propose, both kernel API
> coexist for some time, except it happens in userspace instead of in
> kernel, which is an implementation detail.
> 	So, my question is when can I remove the old ESSID API.

That isn't the question here. 

The current situation seems to be designed to add the new one and removing 
the old one as a single step. THAT IS BROKEN.

The new one and the old one needs to work at the same time, exactly so 
that there's a transition mechanism.

That's the part you seem to now have understood. There should be no "flag 
day" when people have to switch over.

> 	The Wireless people (Jouni, Dan) decided to change the
> *userspace* API. We could translate the new *userspace* API to the old
> kernel API, but I don't see the point.

You do not indeed see the point.

The point is, we can switch internal kernel ABI's - new or old - at any 
point. But user-level ABI's should never require a one-way update.

> 	That's exactly what it hinges on. What is your criteria for
> removing the old ESSID API. My understanding was 6 months.

But we didn't have 6 months of the new API, did we? People complained. 

The person you merged through explicitly said that if he had realized what 
you did, he wouldn't have merged.

That should tell you something. Why are you ignoring this?

			Linus
