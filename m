Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161320AbWJRTeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161320AbWJRTeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161322AbWJRTeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:34:36 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:16733 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161321AbWJRTef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:34:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ns8OSgRFxwljqrGWEKQPZ2Bve2095cm1Y0WKh2DVQH1mJ+8FCj52CZ7TOiplaKGGzcSO105qvcgxG1bBOxJHFeyjxK/bhSu83K9GH9xr+7u1UHcFcB8Rd6a4V+nJSgqgsaY3lnB61wo1bTAKV7eR+5gMw6Nh811YIy5niREKG+c=  ;
Message-ID: <453681C9.7020904@yahoo.com.au>
Date: Thu, 19 Oct 2006 05:34:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] OOM killer meets userspace headers
References: <20061018145305.GA5345@martell.zuzino.mipt.ru> <453642D1.1010302@yahoo.com.au> <20061018184655.GC5345@martell.zuzino.mipt.ru> <45367C93.3040804@yahoo.com.au> <20061018192404.GE5345@martell.zuzino.mipt.ru>
In-Reply-To: <20061018192404.GE5345@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Thu, Oct 19, 2006 at 05:12:19AM +1000, Nick Piggin wrote:
> 
>>Alexey Dobriyan wrote:
>>
>>>On Thu, Oct 19, 2006 at 01:05:53AM +1000, Nick Piggin wrote:
>>>
>>>
>>>>>+#define OOM_ADJUST_MIN (-16)
>>>>>+#define OOM_ADJUST_MAX 15
>>>>
>>>>Why do you need the () for the -ves?
>>>
>>>
>>>-16 is two tokens. Not that someone is going to do huge arithmetic with
>>>OOM adjustments and screwup himself, but still...
>>
>>How can they screw themselves up? AFAIKS, the - directly to the left
>>of the literal will bind more tightly than any other valid operator.
> 
> 
> Hmmm... c.l.c lists two reasons: a) =- being synonym of -= in pre-ANSI
> days, and b) fat fingers
> 
> 	#define EOF -1
> 	while ((c = getchar()) != 3 EOF)

I can't say I care about those problems to justify the uglification
(or churning the tree).

If the operator were legitimately able to leak out, obviously () is
a good thing. Otherwise...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
