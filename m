Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbVINRfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbVINRfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVINRfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:35:18 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:20146 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965243AbVINRfR (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:35:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=l6EvFjQgJirXQ2Jt5VARI/6ac5PfstsobITK9UT2TxY0BH0cXN646pgi5L+fEkqVmmt8gENHaDPzMFfqDe2GVrzzik5llI5ueljqyqwquc7xbxz2F5kQkg6iKsEdq9J9Sz/2H8bD4VauKYTHfimZmBqcaEYwz2boO5/xa6zn9c0=  ;
Message-ID: <43285818.9060805@yahoo.com.au>
Date: Thu, 15 Sep 2005 03:04:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au>
In-Reply-To: <43285374.3020806@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Roman Zippel wrote:
> 
>> Hi,
>>
>> On Thu, 15 Sep 2005, Nick Piggin wrote:
>>
>>
>>> Also needs work on those same architectures. Other architectures
>>> might want to look at providing a more optimal implementation.
>>
>>
>>
>> IMO a rather pointless primitive, unless there is a cpu architecture 
>> which has a inc_not_zero instruction, otherwise it will always be the 
>> same as using cmpxchg.
>>
> 

[snip]

But even supposing the cmpxchg variant was the highest
performing implementation available on any architecture, I
would still consider exporting the inc_not_zero instruction.

The reason is that cmpxchg is not nearly so readable as
inc_not_zero when used inline in the code.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
