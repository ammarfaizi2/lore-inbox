Return-Path: <linux-kernel-owner+w=401wt.eu-S965109AbXAJWK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbXAJWK2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbXAJWK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:10:28 -0500
Received: from mail.tmr.com ([64.65.253.246]:40532 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965109AbXAJWK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:10:27 -0500
Message-ID: <45A56453.9060707@tmr.com>
Date: Wed, 10 Jan 2007 17:10:27 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: bunk@stusta.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.20-rc4: regression: iptables failed to load rules
References: <5157576d0701082329o1875911j20f6679e2d35bb17@mail.gmail.com> <Pine.LNX.4.64.0701090929160.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701090929160.3594@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 9 Jan 2007, Tomasz Kvarsin wrote:
>> During boot into 2.6.20-rc4 iptables says
>> iptables-restore: line 15 failed.
>> And works fine with my default kernel: 2.6.18.x
> 
> I bet you enabled the new transport-agnostic netfilter, and didn't enable 
> some of the actual rules needed for your iptables setup (they have new 
> config names).
> 
> I do think that the netfilter team has been very irritating in changing 
> the config names, even if it "is logical". 
> 
> Somebody should stop the madness, and tell people what config options they 
> need for a regular iptables setup like this. Rather than say "just compile 
> everything". There's about a million different filters, and they all 
> depend on one infrastructure or another.
> 
> And then the networking people should F*NG STOP that config name changing 
> madness! The config names should match the _usage_, not some 
> implementation detail. And failing that, leave the config options named 
> something illogical, as long as people don't have to change their config 
> file all the time and answer millions of questions that they don't care 
> about!

This could apply to some other things, like PAE support. Instead of 
having to know what memory models set what option which impact 
virtualization, set the option if the feature is needed for any config 
option choice. This probably hits people wanting virtualization on small 
memory machines more than others.
