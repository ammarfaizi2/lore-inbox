Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWDVTZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWDVTZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWDVTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:25:57 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:14954 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751059AbWDVTZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:25:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=q1TpymbQ3qluxHkvGWFZUqkv1u5J8JVLCSWZqPe72uCLJYpeWdfm3DQehUsPBQtGFWQHArsDtf9Kw2s+FVd8zIPloAzMrMJ1lyZIgU+b4Fot0ouKW9Fl8b7qAtFGPmkbAo7SUz7e1+Ope02LZO/YV/zXGnGUB5Fy45MupGdjoTo=  ;
Message-ID: <444A8335.6030407@yahoo.com.au>
Date: Sun, 23 Apr 2006 05:25:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: "'Paul Mackerras'" <paulus@samba.org>,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       "'Andrew Morton'" <akpm@osdl.org>, "'James Morris'" <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
References: <001b01c66642$0abdbf80$0200a8c0@nuitysystems.com>
In-Reply-To: <001b01c66642$0abdbf80$0200a8c0@nuitysystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
>>It can reduce readability of the code [unless it is used in 
>>error path simplification, kfree(something) usually suggests 
>>kfree-an-object].
> 
> 
> Consistency in coding style improves readability. Redundancy reduces readability.
> 
> The interface is simple and clear, and has been documented for decades, that is kfree (and free) accepts NULL. There is no ambiguity
> here.
> 
> If you think "if (obj) kfree (obj);" is more readable than "kfree(obj);", fix the API to enforce it.
> 
> But if the kernel tree is full of "some caller checks NULL while others not", I hardly see it as readable. It'd just be confusing.
>  
> 
>>I don't actually like kfree(NULL) any time except error 
>>paths. It is subjective, not crazy talk.
> 
> 
> Documented interface is not subjective.

That's great. I don't know quite how to reply, or even if I should
if you don't read what I write.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
