Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbTGDGvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 02:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTGDGvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 02:51:15 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:58773 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265802AbTGDGvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 02:51:14 -0400
Date: Fri, 4 Jul 2003 09:05:41 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Sipek <jeffpc@optonline.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
Message-ID: <20030704070541.GA20475@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Jeff Sipek <jeffpc@optonline.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>
References: <200307032231.39842.jeffpc@optonline.net> <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 08:08:03PM -0700, Linus Torvalds wrote:

> Please do this in user space. The "overflow every 2^32 packets" thing is 
> _not_ a problem, if you just gather the statistics at any kind of 
> reasonable interval.

At 114 megabits/second, we pass the mrtg threshold of an overflow within 5
minutes. A 1 gigabit link will do this once every 34 seconds. There are 10
gigabit adaptors out there which may need to be polled once every 3 seconds
then.

> Remember: "perfect is the enemy of good". 

Pretty good is not however. Can't we do what we do for jiffies where we only
do a 64 bit operation very seldomly?

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
