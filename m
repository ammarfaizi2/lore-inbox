Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265428AbUFRQ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265428AbUFRQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUFRQ6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:58:35 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:27627 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S265428AbUFRQ4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:56:14 -0400
Message-ID: <40D31EA6.5030207@ThinRope.net>
Date: Sat, 19 Jun 2004 01:56:06 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
References: <200406181611.37890.andrew@walrond.org> <40D313DC.7000202@blue-labs.org> <200406181721.47968.andrew@walrond.org>
In-Reply-To: <200406181721.47968.andrew@walrond.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> Hi David,
> 
> On Friday 18 Jun 2004 17:10, David Ford wrote:
> 
>>Iptables should be using linux-libc-headers headers instead of kernel
>>headers.
> 
> 
> Is this acquired knowledge, or new Netfilter policy?
> How dependant are the iptables tools on the specifc kernel running?
> 
> Ie
> Can I build iptables for use on 2.6.7 kernel with 2.6.6 linux-libc-headers? 
> (probably)
> 
> But could I build iptables for 2.6.7 kernel with 2.4.20 linux-libc-headers? 
> (probably not?)
> 
> The INSTALL file states specifically to use 
> KERNEL_DIR=<<where-you-built-your-kernel>>
> 
> Andrew

Yes, I confirm with linux-2.6.7 and iptables-1.2.9 I got:
gcc -march=athlon-xp -m3dnow -msse -mfpmath=sse -mmmx -O3 -pipe -Iinclude -Wall -Wunused -I/usr/src/linux/include  -DIPTABLES_VERSION=\"1.2.9\"  -fPIC -o extensions/libipt_stealth_sh.o -c extensions/libipt_stealth.c
distcc[6323] ERROR: compile on localhost failed
In file included from include/libiptc/libiptc.h:6,
                 from include/iptables.h:5,
                 from extensions/libipt_stealth.c:10:
/usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:255: warning: no semicolon at end of struct or union
/usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:255: error: syntax error before '*' token
/usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:259: error: syntax error before '}' token
/usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:339: warning: type defaults to `int' in declaration of `DECLARE_MUTEX'
/usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:339: warning: parameter names (without types) in function declaration
/usr/src/linux/include/linux/netfilter_ipv4/ip_tables.h:339: warning: `DECLARE_MUTEX' declared `static' but never defined
make: *** [extensions/libipt_stealth_sh.o] Error 1

Last time I recompiled it with 2.6.6 it was ok. The compiled version still seems to work with 2.6.7 for now.

However, isn't that supposed to be filed with iptables (@netfilter.org)?

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
