Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVHEOgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVHEOgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVHEOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:36:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31459
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261759AbVHEOf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:35:56 -0400
Date: Fri, 05 Aug 2005 07:36:07 -0700 (PDT)
Message-Id: <20050805.073607.78730729.davem@davemloft.net>
To: rostedt@goodmis.org
Cc: ak@suse.de, mingo@elte.hu, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, sandos@home.se
Subject: Re: lockups with netconsole on e1000 on media insertion
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1123252026.18332.37.camel@localhost.localdomain>
References: <1123251013.18332.28.camel@localhost.localdomain>
	<20050805141426.GU8266@wotan.suse.de>
	<1123252026.18332.37.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 05 Aug 2005 10:27:06 -0400

> Darn it, since this should really be reported.  Yes, the core netpoll
> should bail out, but it is also a problem with the driver and should be
> fixed.

I don't get how you can even remotely claim this to
be a problem with the driver.

If there is no cable plugged in, the link never comes
up, and that is a completely normal thing.  The netpoll
code should simply not try forever to wait for the link
to go up.
