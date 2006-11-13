Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755148AbWKMPmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbWKMPmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbWKMPmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:42:01 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:17872
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1755148AbWKMPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:42:00 -0500
Message-ID: <45589135.9000905@microgate.com>
Date: Mon, 13 Nov 2006 09:37:25 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, khc@pm.waw.pl,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de> <4558860B.8090908@garzik.org> <45588895.7010501@microgate.com> <45588BF0.3000100@garzik.org>
In-Reply-To: <45588BF0.3000100@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Unless someone fixes it The Right Way, my patch seems like the best we 
> can do.  People who complain "you must be able to build without hdlc" 
> should step up and make it so.  Currently, it is not so.

I builds just fine with and without HDLC.

The only problem is defining synclink as built in
while defining hdlc as a module.

This patch *breaks* the driver.

My previous attempts (and those of others who suggested
different fixes) at preventing this kernel
misconfiguration were all rejected. I tried
repeatedly over many weeks.

I think purposefully breaking a driver while rejecting
fixes to the real problem is a bad idea.

-- 
Paul Fulghum
Microgate Systems, Ltd.
