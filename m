Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVKJPKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVKJPKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVKJPKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:10:34 -0500
Received: from rtr.ca ([64.26.128.89]:10908 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750761AbVKJPKd (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:10:33 -0500
Message-ID: <437362F3.4060401@rtr.ca>
Date: Thu, 10 Nov 2005 10:10:43 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: pomac@vapor.com, marado@isp.novis.pt, Linux-kernel@vger.kernel.org,
       fawadlateef@gmail.com, hostmaster@ed-soft.at, jerome.lacoste@gmail.com,
       carlsj@yahoo.com
Subject: Re: New Linux Development Model
References: <1131500868.2413.63.camel@localhost> <1131539876.8930.44.camel@noori.ip.pt> <1131552065.2413.90.camel@localhost> <200511100055.58322.s0348365@sms.ed.ac.uk>
In-Reply-To: <200511100055.58322.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
>
> Eh? WEP seems to work here with different key sizes. I think most people 
> should be satisfied with finally being able to use their wireless controller 
> in ANY form on a Centrino laptop without having to find a driver!

Err.. there are lots of different APs out there,
and the in-kernel borken driver doesn't work for me
with several APs I need to access.

Not to mention that WEP doesn't provide any meaningful security,
whereas the out-of-tree driver even does WPA2 with ease.

The big problem for users, is that they used to be able to just go
and grab the *real* ipw2200 driver, and build/install it with a few
simple commands.

But because the kernel now contains all of this way-outdated
stuff for ieee80211 and ipw2200, there are tons of header file
conflicts and protocol mismatches when attempting to build/use
the real driver.

Sure, us kernel folk can cope with all of that (in theory,
though in practice I'm still stuck with 2.6.13 because I haven't
yet gotten working ipw2200 with 2.6.14, with *either* driver).

But things just got WAY more complicated for most users of ipw2200.
Sure, they can ignore us and just continue to run their old vendor
kernels.  But this means they don't get up-to-date kernels with
bug fixes and security fixes.  And more importantly to LKML,
we've now just cut off a potentially large crowd of kernel-testers.

Ugh.  Ugly.
