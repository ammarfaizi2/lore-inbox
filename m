Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbTGJQFd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266367AbTGJQFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:05:32 -0400
Received: from netcore.fi ([193.94.160.1]:50192 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S266365AbTGJQFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:05:25 -0400
Date: Thu, 10 Jul 2003 19:19:57 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: cat@zip.com.au, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling broken
In-Reply-To: <20030711.011858.117900702.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0307101918080.18224-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> In article <Pine.LNX.4.44.0307101906160.18224-100000@netcore.fi> (at Thu, 10 Jul 2003 19:08:20 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:
> 
> > While technically correct, I'm still not sure if this is (pragmatically) 
> > the correct approach.  It's OK to set a default route to go to the 
> > subnet routers anycast address (so, setting a route to prefix:: should 
> > not give you EINVAL).
> 
> But, on the other side cannot use prefix::, and
> the setting is rather non-sense.

Not really.  From the host perspective:

"I want to set default route to SOME default router" 

(there may be multiple routers in the LAN, while only one at a time is
actively responding to the anycast address; if that one goes away, 
another one takes its place.)
 
> We should educate people not to use /127; use /64 instead.
> v6ops? :-)

That's another story..

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

