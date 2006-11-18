Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755138AbWKRRFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbWKRRFx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbWKRRFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:05:52 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:22767 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1754637AbWKRRFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:05:52 -0500
Message-ID: <455F3D44.4010502@lwfinger.net>
Date: Sat, 18 Nov 2006 11:05:08 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: Joseph Fannin <jhf@columbus.rr.com>, Andrew Morton <akpm@osdl.org>,
       Ray Lee <ray-lk@madrabbit.org>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>,
       John Linville <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>,
       Bcm43xx-dev@lists.berlios.de
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg>
In-Reply-To: <1163868955.27188.2.camel@johannes.berg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> On Sat, 2006-11-18 at 06:24 -0500, Joseph Fannin wrote:
> 
>>     This sounds like what my laptop was doing in -rc5, though mine
>> didn't take hours to start acting up.
>>
>>     I *think* it was the MSI troubles, causing interrupts to get
>> lost forever.  Anyway, it went away in -rc6.
> 
> Hah, that's a lot more plausible than bcm43xx's drain patch actually
> causing this. So maybe somehow interrupts for bcm43xx aren't routed
> properly or something...
> 
> Ray, please check /proc/interrupts when this happens.
> 
> I am convinced that the patch in question (drain tx status) is not
> causing this -- the patch should be a no-op in most cases anyway, and in
> those cases where it isn't a no-op it'll run only once at card init and
> remove some things from a hardware-internal FIFO.

I agree that drain tx status should not cause the problem.

Ray, does -rc6 solve your problem as it did for Joseph?

Larry
