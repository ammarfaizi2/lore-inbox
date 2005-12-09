Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbVLIAJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbVLIAJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 19:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbVLIAJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 19:09:10 -0500
Received: from mail.dvmed.net ([216.237.124.58]:32940 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932760AbVLIAJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 19:09:08 -0500
Message-ID: <4398CB14.6020508@pobox.com>
Date: Thu, 08 Dec 2005 19:08:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org, jmorris@intercode.com.au, laforge@netfilter.org,
       akpm@osdl.org
Subject: Re: [PATCH] Decrease number of pointer derefs in nfnetlink_queue.c
References: <200512082336.01678.jesper.juhl@gmail.com> <20051208.145148.36886043.davem@davemloft.net>
In-Reply-To: <20051208.145148.36886043.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  David S. Miller wrote: > From: Jesper Juhl
	<jesper.juhl@gmail.com> > Date: Thu, 8 Dec 2005 23:36:01 +0100 > >
	>>Here's a small patch to decrease the number of pointer derefs in
	>>net/netfilter/nfnetlink_queue.c >> >>Benefits of the patch: >> -
	Fewer pointer dereferences should make the code slightly faster. >> -
	Size of generated code is smaller >> - improved readability > > > And
	you verified the compiler isn't making these transformations > already?
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Thu, 8 Dec 2005 23:36:01 +0100
> 
> 
>>Here's a small patch to decrease the number of pointer derefs in
>>net/netfilter/nfnetlink_queue.c
>>
>>Benefits of the patch:
>> - Fewer pointer dereferences should make the code slightly faster.
>> - Size of generated code is smaller
>> - improved readability
> 
> 
> And you verified the compiler isn't making these transformations
> already?

Didn't the provided size(1) output would verify this?

In any case, I like the changes because it makes the code more readable, 
with the smaller code size as a pleasant side effect.  Due to increase 
readability, I would only be inclined to NAK if the code 
performance/size was adversely effected.

	Jeff


