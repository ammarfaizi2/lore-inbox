Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265802AbUFWQVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUFWQVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUFWQTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:19:16 -0400
Received: from www.nute.net ([66.221.212.1]:33676 "EHLO mail.nute.net")
	by vger.kernel.org with ESMTP id S265802AbUFWQOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:14:48 -0400
Date: Wed, 23 Jun 2004 16:14:47 +0000
From: Mikael Bouillot <xaajimri@corbac.com>
To: linux-kernel@vger.kernel.org
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: Forcedeth driver bug
Message-ID: <20040623161447.GB11348@mail.nute.net>
References: <20040623142936.GA10440@mail.nute.net> <40D99A08.90707@ThinRope.net> <40D9A857.5040901@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D9A857.5040901@gmx.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure both come back? If so, what does dmesg say during this time?
> Is the system in question under heavy load?
> 
> Can you confirm that the ping packet got stuck in the receive path or
> could the associated pong reply have gotten stuck in the send path?

  A tcpdump at the remote end shows the packet leaving, but a tcpdump at
the local side doesn't show it until the next packet arrives. I tried
this on a system running nothing but tcpdump, but the network load is
high (ping sends packets as soon as the previous reply comes back).


> It could be a weird interaction with interrupt mitigation, but I doubt it.
> Nobody has ever mailed me about such problems with the driver.

  Another note: I run my 2.6.7 with Local APIC and IO-APIC. Maybe that
has to do with interrupt problems. I will try reverting to the older PIC
during further testing to see if that has an effect on things.


> forcedeth_gigabit_try19.txt is the most recent one.
> Changes against try17:
> - fix compilation warnings and rename the Kconfig entry
> 
> Get it at
> http://www.hailfinger.org/carldani/linux/patches/forcedeth/
> and please report if it fixes your problem.

  OK, I'll do that.


-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
