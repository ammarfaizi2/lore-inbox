Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbULXUD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbULXUD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 15:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULXUD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 15:03:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:7848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261444AbULXUDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 15:03:54 -0500
Message-ID: <41CC74D0.4040600@osdl.org>
Date: Fri, 24 Dec 2004 11:58:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Park Lee <parklee_sel@yahoo.com>
CC: adobriyan@mail.ru, sam@ravnborg.org, juhl-lkml@dif.dk, twaugh@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: What's wrong with Documentation/DocBook/kernel-api.tmpl? (was
 Re: Something wrong when transform Documentation/DocBook/*.tmpl into pdf)
References: <20041224115443.55225.qmail@web51506.mail.yahoo.com>
In-Reply-To: <20041224115443.55225.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Park Lee wrote:
> On Thu, 23 Dec 2004 at 23:33, Alexey Dobriyan wrote:
> 
>>On 2004-12-23 19:39:25, Park Lee wrote:
>>
>>>cd
> 
> /usr/src/linux-2.6.5-1.358/Documentation/DocBook
> <ENTER>
> 
>>>make pdfdocs  <ENTER>
>>
>>Correct sequence is:
>>
>>$ cd /usr/src/linux-whatever/
>>$ make pdfdocs
>>
>>pdfs will be at Documentation/DocBook/
> 
> 
> I run the commands as what you said, and it really
> works!
> But there is still one problem: All the other *.tmpl
> in Documentation/DocBook can be transformed into pdf
> except the kernel-api.sgml.
> 
> When I ran the commands, It said on the screen like
> the following:
> 
> [root@lenovo linux-2.6.5-1.358]# make pdfdocs
>   [snipped]
> DOCPROC Documentation/DocBook/kernel-api.sgml

> Error(fs/dcache.c:687): cannot understand prototype:
> 'DENTRY_UNUSED_THRESHOLD 30 000 '

> make[1]: *** [Documentation/DocBook/kernel-api.sgml]
> Error 1
> make: *** [pdfdocs] Error 2
> 
>   Then, what's wrong with kernel-api.tmpl? Why
> couldn't it be transformed into pdf?

Ignore all of the Warning messages (for now) and focus
on the Error message (above).

I don't find DENTRY_UNUSED_THRESHOLD in any .h or .c
or DocBook/* file in linux-2.6.5 (or current), but
maybe they are in your source tree.  Please check
and report where and then we'll see if it needs
to be fixed (or already is fixed).

-- 
~Randy
