Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUKJQ7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUKJQ7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUKJQ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:59:43 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:18638 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S262009AbUKJQ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:59:18 -0500
Message-ID: <41924E34.8060404@drdos.com>
Date: Wed, 10 Nov 2004 10:21:56 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 RCU breakage in dev_queue_xmit
References: <E1CRhaw-0001v7-00@gondolin.me.apana.org.au>
In-Reply-To: <E1CRhaw-0001v7-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>Jeff V. Merkey <jmerkey@drdos.com> wrote:
>  
>
>>Running dual gigabit interfaces at 196 MB/S (megabytes/second) on 
>>receive, 12 CLK interacket gap time, 1500 bytes payload
>>at 65000 packets per second per gigabit interface, and retransmitting 
>>received packets at 130 MB/S out of a third gigabit interface
>>with skb, RCU locks in dev_queue_xmit breaks and enters the following state:
>>    
>>
>
>This patch might help.
>  
>
Fixed.   Who an earth missed that?  dropping into an unlock case
by default without holding the lock?

Jeff
