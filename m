Return-Path: <linux-kernel-owner+w=401wt.eu-S1751279AbXAILlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbXAILlQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 06:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXAILlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 06:41:16 -0500
Received: from vs02.svr02.mucip.net ([83.170.6.69]:56588 "EHLO mx01.mucip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751279AbXAILlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 06:41:16 -0500
Message-ID: <45A37F5F.2030501@birkenwald.de>
Date: Tue, 09 Jan 2007 12:41:19 +0100
From: Bernhard Schmidt <berni@birkenwald.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug] OOPS with nf_conntrack_ipv6, probably fragmented UDPv6
References: <459D322F.5010707@birkenwald.de> <45A63D72.2060405@trash.net>
In-Reply-To: <45A63D72.2060405@trash.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

>> I've hit another kernel oops with 2.6.20-rc3 on i386 platform. It is
>> reproducible, as soon as I load nf_conntrack_ipv6 and try to send
>> something large (scp or so) inside an OpenVPN tunnel on my client
>> (patched with UDPv6 transport) the router (another box) OOPSes.
>>
>> tcpdump suggests the problem appears as soon as my client sends
>> fragmented UDPv6 packets towards the destination. It does not happen
>> when nf_conntrack_ipv6 is not loaded. This is the OOPS as dumped from
>> the serial console:
> Does this patch help?

Yes, seems to be working fine.

Can you tell since when this bug is in the kernel?

Regards,
Bernhard
