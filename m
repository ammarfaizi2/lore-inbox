Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWIJCHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWIJCHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 22:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWIJCHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 22:07:11 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:48625 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S965089AbWIJCHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 22:07:09 -0400
Date: Sat, 09 Sep 2006 22:07:07 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: netdevice name corruption is still present in 2.6.18-rc6-mm1
In-reply-to: <20060909032939.GA3087@nickolas.homeunix.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Patrick McHardy <kaber@trash.net>
Mail-followup-to: linux-kernel <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@osdl.org>, Patrick McHardy <kaber@trash.net>
Message-id: <20060910020707.GA3160@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <20060909032939.GA3087@nickolas.homeunix.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:29:39PM -0400, Nick Orlov wrote:
> Andrew,
> 
> I would like to confirm that issue with netdevice name corruption
> is still present in 2.6.18-rc6-mm1 and extremely easy to reproduce
> (at least on my system) with 100% hit rate.
> 
> All I have to do is 'sudo /etc/init.d/networking stop'. And here we go:
> 
> Sep  8 22:50:11 nickolas kernel: [events/1:7]: Changing netdevice name from [ath0] to [\200^C^BÂ\206]
> 

Confirmed: Patrick's patch fixes the issue for me.
(http://marc.theaimsgroup.com/?l=linux-kernel&m=115777959918268&w=2)

Thank you,
	Nick Orlov.

P.S. I'm not subscribed to the list so I had to reply to my own mail in
a hope that it will make it to the right thread.

