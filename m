Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVBGRzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVBGRzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVBGRzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:55:53 -0500
Received: from mailhub2.nextra.sk ([195.168.1.110]:55567 "EHLO toe.nextra.sk")
	by vger.kernel.org with ESMTP id S261209AbVBGRzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:55:47 -0500
Message-ID: <4207AC02.8010407@rainbow-software.org>
Date: Mon, 07 Feb 2005 18:57:22 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Charles-Edouard Ruault <ce@idtect.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: IO port conflict between timer & watchdog on PCISA-C800EV board
 ?
References: <420734DC.4020900@idtect.com> <420797DE.6030904@osdl.org>
In-Reply-To: <420797DE.6030904@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
[...]
> /proc/ioports timer assignments have now been split up like this:
> 0040-0043 : timer0
> 0050-0053 : timer1
> 
> However, port 0x43 is still assigned to timer0, so your request_region
> call will still fail.  What system board timer resource assignments
> should be used for that VIA chipset?  If the chipset timer only needs
> 0x40-0x42, e.g., leaving 0x43 available, then it would be possible
> to do some kind of workaround (maybe not real clean, but possible).

The timer uses ports 0x40-0x43. However, port 0x43 is defined as WO 
(write-only) - it's timer command register.

-- 
Ondrej Zary
