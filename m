Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTD2Llm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTD2Llm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:41:42 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:17892 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261759AbTD2Lll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:41:41 -0400
Message-ID: <3EAE67EC.5060702@superbug.demon.co.uk>
Date: Tue, 29 Apr 2003 12:54:20 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Wourms <dragon@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac3: unresolved symbol only with gcc-3.3
References: <20030429104434.GA19733@neon.pearbough.net> <3EAE6384.3050702@gentoo.org>
In-Reply-To: <3EAE6384.3050702@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Wourms wrote:

> Axel Siebenwirth wrote:
>
>> Hi,
>>
>> today I have successfully built 2.4.21-rc1-ac3 with gcc-3.2.3. 
>> Everything
>> was fine.
>> Then I built with gcc-3.3 and I encountered an error:
>>
>> net/network.o(.text+0xdcd7): In function `rtnetlink_rcv':
>> : undefined reference to `rtnetlink_rcv_skb'
>>
>> This build error only occurs with gcc-3.3.
>>
>> Can somebody who knows the kernel look whether the error is 
>> legitimate or gcc is making errors.
>
>
> I'm not sure if this is necessarily the right way, but changing the 
> declaration for rtnetlink_rcv_skb() in net/core/rtnetlink.c from 
> "extern" to "static" seems to have fixed the problem for me.  In any 
> case, I couldn't find any external references to that function, so it 
> seems to me that this is the way to go.
>
> Cheers,
> Nicholas
>
>
Please ignore my last email. I in fact did the same as Nicholas and it 
fixed it for me.
I also had a problem in the reiserfs module, with a kprintf statement 
format string spread over two lines. Removing what looked like a 
misplaced newline fixed it.

Cheers
James


