Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWHUXsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWHUXsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWHUXsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:48:13 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:30608 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750736AbWHUXsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:48:12 -0400
Date: Tue, 22 Aug 2006 00:48:10 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 BUG, drm relatedy
In-Reply-To: <20060821140848.GB1919@slug>
Message-ID: <Pine.LNX.4.64.0608220047000.658@skynet.skynet.ie>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060815130345.GA3817@slug>
 <20060819230821.GE720@slug> <Pine.LNX.4.64.0608211223030.16712@skynet.skynet.ie>
 <20060821140848.GB1919@slug>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I've been busy lately so having trouble following this stuff in a timely manner, I think this is an error path which the
>> userpsace code doesn't clean up properly, your patch is most definitely not correct..
> I see. So this is most likely X's having trouble with the EFAULT on
> unlock? I've gone through the 2.6.18-rc4-mm1 patches, and I couldn't
> relate the updates and that new drm_unlock() error message. Any idea?
>>
>> if I had to guess I'd say you have an AGP machine + card but no AGP support driver loaded...
> I've got CONFIG_AGP=y and CONFIG_AGP_INTEL=y, do I need some more
> options? What's strange is that this worked perfectly with
> 2.6.18-rc3-mm2...


Can you startup without X, do
echo 1 > /sys/modules/drm/parameters/debug

start X, and send me the dmesg output up to the oops?

Don't cc the list as I suspect it will be quite large..

Dave.
