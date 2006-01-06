Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWAFMq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWAFMq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWAFMq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:46:56 -0500
Received: from stinky.trash.net ([213.144.137.162]:24741 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751195AbWAFMqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:46:54 -0500
Message-ID: <43BE6697.3030009@trash.net>
Date: Fri, 06 Jan 2006 13:46:15 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Michael Buesch <mbuesch@freenet.de>, jgarzik@pobox.com,
       bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
References: <1136541243.4037.18.camel@localhost>	 <200601061200.59376.mbuesch@freenet.de>	 <1136547494.7429.72.camel@localhost>	 <200601061245.55978.mbuesch@freenet.de> <1136549423.7429.88.camel@localhost>
In-Reply-To: <1136549423.7429.88.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:

>>I just personally liked the idea of having a device node in /dev for
>>every existing hardware wlan card. Like we have device nodes for
>>other real hardware, too. It felt like a bit of a "unix way" to do
>>this to me. I don't say this is the way to go.
>>If a netlink socket is used (which is possible, for sure), we stay with
>>the old way of having no device node in /dev for networking devices.
>>That is ok. But that is really only an implementation detail (and for sure
>>a matter of taste).
> 
> 
> At the OLS last year, I think the consensus was to use netlink for all
> configuration task. However this was mainly driven by Harald Welte and
> he might be able to talk about the pros and cons of netlink versus a
> character device.

I think the main advantages of netlink over a character device is its
flexible format, which is easily extendable, and multicast capability,
which can be used to broadcast events and configuration changes. Its
also good to have all the net stuff accessible in a uniform way.
