Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbUKROMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUKROMH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKROKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:10:38 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:20161 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261813AbUKROJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:09:31 -0500
Message-ID: <419CAD19.4030203@mvista.com>
Date: Thu, 18 Nov 2004 08:09:29 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH} Network interface for IPMI
References: <31Fe2-5kB-11@gated-at.bofh.it> <p73oehv22oz.fsf@brahms.suse.de>
In-Reply-To: <p73oehv22oz.fsf@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I agree.  You are right, at least the ioctls can be fixed up.

-Corey

Andi Kleen wrote:

>Corey Minyard <cminyard@mvista.com> writes:
>
>  
>
>>I have decided
>>that the network interface for IPMI is a good thing, as the IPMI
>>device ioctls have pointers and require ugly hacks.  None should be
>>needed for the network interface.
>>    
>>
>
>That's a joke, right? 
> 
>
>  
>
>>+struct ipmi_sock_msg {
>>+	int                   recv_type;
>>+	long                  msgid;
>>    
>>
>        ^^^^^^^^^^^
>
>Of course long would need to be always emulated. Your patch
>shows exactly why packet based protocols for this are a bad
>idea. The problem is that people will get it wrong, and then
>it's nearly impossible to fix for a socket based protocol
>because read/write cannot be easily hooked
>(with ipsec we have exactly this problem already)
>
>ioctls at least can be fixed up. Please keep using them.
>
>  
>
>>+	int                   data_len;
>>+	unsigned char         data[0];
>>    
>>
>
>And I don't even want to know what's in there.
>
>Andrew, please don't apply this broken patch.
>
>-Andi
>
>  
>

