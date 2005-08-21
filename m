Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVHUVov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVHUVov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVHUVok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:44:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:6606 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751169AbVHUVoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:44:39 -0400
Message-ID: <4308A8A0.9060402@trash.net>
Date: Sun, 21 Aug 2005 18:15:28 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050821154654.63788.qmail@web33303.mail.mud.yahoo.com>
In-Reply-To: <20050821154654.63788.qmail@web33303.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
> I just started fiddling with 2.6.12, and there
> seems to be a big drop-off in performance from
> 2.4.x in terms of networking on a uniprocessor
> system. Just bridging packets through the
> machine, 2.6.12 starts dropping packets at
> ~100Kpps, whereas 2.4.x doesn't start dropping
> until over 350Kpps on the same hardware (2.0Ghz
> Opteron with e1000 driver). This is pitiful
> prformance for this hardware. I've 
> increased the rx ring in the e1000 driver to 512
> with little change (interrupt moderation is set
> to 8000 Ints/second). Has "tuning" for MP 
> destroyed UP performance altogether, or is there
> some tuning parameter that could make a 4-fold
> difference? All debugging is off and there are 
> no messages on the console or in the error logs.
> The kernel is the standard kernel.org dowload
> config with SMP turned off and the intel ethernet
> card drivers as modules without any other
> changes, which is exactly the config for my 2.4
> kernels.

Do you have netfilter enabled? Briging netfilter was
added in 2.6, enabling it will influence performance
negatively. Otherwise, is this performance drop
visible in other setups besides bridging as well?
