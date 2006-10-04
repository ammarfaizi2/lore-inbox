Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWJDTNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWJDTNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWJDTNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:13:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:64959 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750851AbWJDTNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:13:15 -0400
Message-ID: <452407BA.7030002@garzik.org>
Date: Wed, 04 Oct 2006 15:12:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linus Torvalds <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com>
In-Reply-To: <20061004185903.GA4386@bougret.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Wed, Oct 04, 2006 at 11:38:19AM -0700, Linus Torvalds wrote:
>>
>> On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
>>> 	You can't froze kernel userspace API forever. That is simply
>>> not workable
>> Stop arguing this way.
>>
>> It's not what we have ever done. We've _extended_ the API. But we don't 
>> break old ones.
> 
> 	Old APIs get deprecated, and people are forced to the new API,
> which is exactly the same as far as userspace is concerned. This
> transition is exactly the same as what you propose, both kernel API
> coexist for some time, except it happens in userspace instead of in
> kernel, which is an implementation detail.
> 	So, my question is when can I remove the old ESSID API.
> 
>> I don't even see why you argue. Even the people directly involved with 
>> this thing seem to say that it should have some simple translation layer 
>> and do the internal format thing. We've had major subsystem that do that, 
>> and I don't see why you think wireless is so different, and so special in 
>> this respect.
> 
> 	The Wireless people (Jouni, Dan) decided to change the
> *userspace* API. We could translate the new *userspace* API to the old
> kernel API, but I don't see the point.

Kernel API and userspace API are two vastly different things.  We change 
the kernel API all the time.  We _don't_ change the userspace API, 
except when "change" is defined as an additional to an existing API.


>> If you need to break something, you create a new interface, and try to 
>> translate between the two, and maybe you deprecate the old one so that it 
>> can be removed once it's not in use any more.
> 
> 	That's exactly what it hinges on. What is your criteria for
> removing the old ESSID API. My understanding was 6 months.

There is no reason why the old ESSID API cannot live on for years and 
years.  Just like stat(2) version 1 doesn't support modern time 
granularity, old ESSID API won't support the full range of modern 
ESSIDs.  So what?  That's what a new API -- living alongside the old one 
-- is for.

	Jeff



