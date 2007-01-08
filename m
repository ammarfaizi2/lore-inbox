Return-Path: <linux-kernel-owner+w=401wt.eu-S965290AbXAHBUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbXAHBUI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbXAHBUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:20:08 -0500
Received: from vs02.svr02.mucip.net ([83.170.6.69]:49046 "EHLO mx01.mucip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965290AbXAHBUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:20:06 -0500
Message-ID: <45A19C42.8080109@birkenwald.de>
Date: Mon, 08 Jan 2007 02:20:02 +0100
From: Bernhard Schmidt <berni@birkenwald.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.20-rc4: known unfixed regressions
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070108002208.GO20714@stusta.de>
In-Reply-To: <20070108002208.GO20714@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19.

> Subject    : netfilter conntrack Oopses
> References : http://lkml.org/lkml/2007/1/4/156

Netfilter bugzilla #528
https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=528

fixed, I think the patch is in -rc4 already (it is listed in the "Merge 
/pub/scm/linux/kernel/git/davem/net-2.6" on Jan. 4th in the git browser)

>              http://lkml.org/lkml/2007/1/7/188

Netfilter bugzilla #529
https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=529

no patch available yet, remote DoS attack for 2.6.20-rc3, not excluded 
this has been the case since nf_conntrack_ipv6 was available (2.6.16 or 
so), UDPv6 fragments are rare in the wild and a large number of users 
could not use nf_conntrack_ipv6 up to now due to incompatibility with 
IPv4 NAT code.

Regards,
Bernhard
