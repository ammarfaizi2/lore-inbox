Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVHRFsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVHRFsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVHRFsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:48:07 -0400
Received: from [85.8.12.41] ([85.8.12.41]:44691 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750766AbVHRFsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:48:06 -0400
Message-ID: <43042114.7010503@drzeus.cx>
Date: Thu, 18 Aug 2005 07:48:04 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org>
In-Reply-To: <20050817155641.12bb20fc.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>The fact that this is enabled under the experimental
>CONFIG_MMC_BULKTRANSFER seems unfortunate.  I mean, if the code works OK
>then we should just enable it unconditionally, no?
>
>  
>

It was made this way to make Russell more open to it. I have since not
recieved any more comments from him so I figured I could pass it by you
instead to get more wide spread testing. The long term goal was removing
the config and having it on all the time.

>I'm thinking that it would be better to not have the config option there
>and then re-add it late in the 2.6.14 cycle if someone reports problems
>which cannot be fixed.  Or at least make it default to 'y' so we get more
>testing coverage, then remove the config option later.  Or something.
>
>Thoughts?
>  
>

Removing it would be preferable by me. All that #ifdef tends to clutter
up the code. After som initial problem with a buggy card everything has
worked flawlesly.

Rgds
Pierre

