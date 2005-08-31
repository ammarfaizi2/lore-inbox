Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVHaJ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVHaJ4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 05:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVHaJ4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 05:56:13 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:9824 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750727AbVHaJ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 05:56:12 -0400
Message-ID: <43157EB8.8040108@gentoo.org>
Date: Wed, 31 Aug 2005 10:56:08 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Steve Kieu <haiquy@yahoo.com>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
References: <20050830133918.42444cae@dxpl.pdx.osdl.net>	<20050830205027.59306.qmail@web53609.mail.yahoo.com> <20050830140516.316e9695@dxpl.pdx.osdl.net>
In-Reply-To: <20050830140516.316e9695@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> You have a version of the Marvell Yukon that was affected
> by a fix in 2.6.13.
> 	skge addr 0xfeaf8000 irq 19 chip Yukon-Lite rev 9
> 
> Both the skge and sk98lin driver were fixed to check for this.
> Without the fix, the chip will be in the wrong power mode.
> 
> The version of sk98lin driver from SysKonnect already had the
> fix, so if your distro used that one, it would have the reset
> the power mode as needed.

So, am I right in saying we can't do anything in skge to work around this to 
allow those older buggy drivers to work on the next reboot? More reports are 
cropping up, e.g.:

	http://forums.gentoo.org/viewtopic-t-375828.html

Given that it seems to be affecting the Windows drivers too, it would be great 
if something could be done.

Thanks,
Daniel
