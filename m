Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVAVXyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVAVXyj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 18:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVAVXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 18:54:39 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78]:36012 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261158AbVAVXyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 18:54:37 -0500
Date: Sat, 22 Jan 2005 18:54:35 -0500
From: sean <seandarcy@hotmail.com>
Subject: Re: Linux 2.6.11-rc2
In-reply-to: <1106402669.20995.23.camel@tux.rsn.bth.se>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <41F2E7BB.2050405@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050109
 Fedora/1.7.5-3
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
 <20050121223247.65c544f8@laptop.hypervisor.org>
 <1106402669.20995.23.camel@tux.rsn.bth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:
> On Fri, 2005-01-21 at 22:32 -0800, Udo A. Steinberg wrote:
> 
>>On Fri, 21 Jan 2005 18:13:55 -0800 (PST) Linus Torvalds (LT) wrote:
>>
>>LT> Ok, trying to calm things down again for a 2.6.11 release.
>>
>>Connection tracking does not compile...
>>
>> CC      net/ipv4/netfilter/ip_conntrack_standalone.o
>>In file included from net/ipv4/netfilter/ip_conntrack_standalone.c:34:
>>include/linux/netfilter_ipv4/ip_conntrack.h:135: warning: "struct ip_conntrack" declared inside parameter list
>>include/linux/netfilter_ipv4/ip_conntrack.h:135: warning: its scope is only this definition or declaration, which is probably not what you want
>>include/linux/netfilter_ipv4/ip_conntrack.h:305: warning: "enum ip_nat_manip_type" declared inside parameter list
>>include/linux/netfilter_ipv4/ip_conntrack.h:306: error: parameter `manip' has incomplete type
>>include/linux/netfilter_ipv4/ip_conntrack.h: In function `ip_nat_initialized':
>>include/linux/netfilter_ipv4/ip_conntrack.h:307: error: `IP_NAT_MANIP_SRC' undeclared (first use in this function)
>>include/linux/netfilter_ipv4/ip_conntrack.h:307: error: (Each undeclared identifier is reported only once
>>include/linux/netfilter_ipv4/ip_conntrack.h:307: error: for each function it appears in.)
> 
> 
> The problem is when compiling without NAT...
> The patch below should fix it, I can compile both with and without NAT
> now.
> 

I'm compiling with NAT, and get a different problem:

   LD      net/ipv4/netfilter/built-in.o
net/ipv4/netfilter/ip_nat_tftp.o(.bss+0x0): multiple definition of `ip_nat_tftp_hook'
net/ipv4/netfilter/ip_conntrack_tftp.o(.bss+0x0): first defined here
make[3]: *** [net/ipv4/netfilter/built-in.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2

sean
