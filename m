Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUFZCYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUFZCYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 22:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbUFZCYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 22:24:54 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:19126 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S265743AbUFZCYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 22:24:48 -0400
Message-ID: <40DCDDF4.7030509@tomt.net>
Date: Sat, 26 Jun 2004 04:22:44 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "David S. Miller" <davem@redhat.com>
Subject: Re: TCP-RST Vulnerability - Doubt
References: <40DC9B00@webster.usu.edu> <20040625150532.1a6d6e60.davem@redhat.com>
In-Reply-To: <20040625150532.1a6d6e60.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>>Could you kindly share your views regarding what Linux has done to its stack 
>>to overcome this vulnerability as it will be of great help to my research.
> 
> 
> We have done nothing, and there are no plans to implement any workaround
> for this problem.
> 
> RFC2385 MD5 hashing support is going in soon, and for the application where
> the vulnerability actually matters (BGP sessions between backbone routers)
> MD5 clears that problem right up and they're all using MD5 protection already
> anyways.

Now you got me curious :-)

I have not seen anything conclusive on this yet. How sensitive is Linux 
to the attack? Some say it deals with it better than others did before 
they got "fixed", but with no hard evidence or a sensible explanation.

Lets assume you're on a FastEthernet pipe capable of delivering 144kpps. 
How "hard" would it be to exploit it in such a scenario, given we know 
the source port and approximate system time used on one of the ends?

Sure, on a FastEthernet your pipe is toast if someone really wants your 
arse anyway, but you don't want connections over other pipes, or 
internally, to die during such an attack.

-- 
Cheers,
André Tomt
