Return-Path: <linux-kernel-owner+w=401wt.eu-S932289AbXAIRd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXAIRd5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbXAIRd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:33:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55644 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbXAIRd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:33:56 -0500
Date: Tue, 9 Jan 2007 09:33:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tomasz Kvarsin <kvarsin@gmail.com>,
       "David S. Miller" <davem@davemloft.net>
cc: bunk@stusta.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.20-rc4: regression: iptables failed to load rules
In-Reply-To: <5157576d0701082329o1875911j20f6679e2d35bb17@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701090929160.3594@woody.osdl.org>
References: <5157576d0701082329o1875911j20f6679e2d35bb17@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2007, Tomasz Kvarsin wrote:
>
> During boot into 2.6.20-rc4 iptables says
> iptables-restore: line 15 failed.
> And works fine with my default kernel: 2.6.18.x

I bet you enabled the new transport-agnostic netfilter, and didn't enable 
some of the actual rules needed for your iptables setup (they have new 
config names).

I do think that the netfilter team has been very irritating in changing 
the config names, even if it "is logical". 

Somebody should stop the madness, and tell people what config options they 
need for a regular iptables setup like this. Rather than say "just compile 
everything". There's about a million different filters, and they all 
depend on one infrastructure or another.

And then the networking people should F*NG STOP that config name changing 
madness! The config names should match the _usage_, not some 
implementation detail. And failing that, leave the config options named 
something illogical, as long as people don't have to change their config 
file all the time and answer millions of questions that they don't care 
about!

David, please crack some heads.

		Linus
