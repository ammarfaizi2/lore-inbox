Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWJDTAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWJDTAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWJDTAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:00:04 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:21711 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1750800AbWJDTAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:00:00 -0400
Date: Wed, 4 Oct 2006 11:59:03 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004185903.GA4386@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 11:38:19AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
> > 
> > 	You can't froze kernel userspace API forever. That is simply
> > not workable
> 
> Stop arguing this way.
> 
> It's not what we have ever done. We've _extended_ the API. But we don't 
> break old ones.

	Old APIs get deprecated, and people are forced to the new API,
which is exactly the same as far as userspace is concerned. This
transition is exactly the same as what you propose, both kernel API
coexist for some time, except it happens in userspace instead of in
kernel, which is an implementation detail.
	So, my question is when can I remove the old ESSID API.

> I don't even see why you argue. Even the people directly involved with 
> this thing seem to say that it should have some simple translation layer 
> and do the internal format thing. We've had major subsystem that do that, 
> and I don't see why you think wireless is so different, and so special in 
> this respect.

	The Wireless people (Jouni, Dan) decided to change the
*userspace* API. We could translate the new *userspace* API to the old
kernel API, but I don't see the point.

> If you need to break something, you create a new interface, and try to 
> translate between the two, and maybe you deprecate the old one so that it 
> can be removed once it's not in use any more.

	That's exactly what it hinges on. What is your criteria for
removing the old ESSID API. My understanding was 6 months.

	Jean
