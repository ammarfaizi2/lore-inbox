Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbUKQJ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUKQJ76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUKQJ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:59:58 -0500
Received: from mail.dif.dk ([193.138.115.101]:18823 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262253AbUKQJ6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:58:49 -0500
Message-ID: <419B2006.3070609@dif.dk>
Date: Wed, 17 Nov 2004 10:55:18 +0100
From: Jesper Juhl <juhl-lkml@dif.dk>
Organization: DIF
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, davem@davemloft.net
Subject: Re: [PATCH 1/2] - net/socket.c::sys_bind() cleanup.
References: <Xine.LNX.4.44.0411162315420.29418-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0411162315420.29418-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Wed, 17 Nov 2004, Jesper Juhl wrote:
> 
> 
>>Not exactely : 
>>
>>
>>
>>>-		if((err=move_addr_to_kernel(umyaddr,addrlen,address))>=0) {
>>
>>>+	err = move_addr_to_kernel(umyaddr, addrlen, address);
>>>+	if (err)
>>>+		goto out_put;
>>
>>
>>The original tests for err >= 0, your replacement tests if err is != 0
> 
> 
> Look at move_addr_to_kernel(), it only returns 0 or -error.
> 
> The patch looks good to me.
> 
Right, I had not looked at it in detail. I just reacted to the claim 
that "it does exactely the same" but I could see in the posted patch 
that it didn't do exactely the same and there was no explanation of why 
it was ok to have that difference.
After reading move_addr_to_kernel(), I agree that the patch looks fine.

--
Jesper Juhl
