Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWJOHti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWJOHti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 03:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWJOHti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 03:49:38 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:19333 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964825AbWJOHth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 03:49:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=F+cOcvnLdXGtx9wefd07WXnmfi1xgLXtQmWMPLOltYZbTPjdYxon2WCgVnkW5BlqtIjiq2KgsTc0Q8/4Mo2FhzTRpkRUtwRdqSNtxKoLP3K+/m6NNdyN8iudGiAeRPB2qEgJv8Mk7hIPQa7fVqyIu/Ihkowxe24whQ0OkKTwrz0=  ;
Message-ID: <4531E80A.6@yahoo.com.au>
Date: Sun, 15 Oct 2006 17:49:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: syphir@syphir.sytes.net
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at fs/inotify.c:181 with linux-2.6.18
References: <452581D7.5020907@syphir.sytes.net> <4525B546.7070305@yahoo.com.au> <6bffcb0e0610141056t44365ab2p3972d0a95dba33da@mail.gmail.com> <45312CDC.8090703@syphir.sytes.net>
In-Reply-To: <45312CDC.8090703@syphir.sytes.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.Y.M wrote:
> Michal Piotrowski wrote:
> 
>>On 06/10/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>>C.Y.M wrote:
>>>
>>>>Since I updated to 2.6.18, I have had the following warnings in my
>>>
>>>syslog.  Is
>>>
>>>>this a known problem? Better yet, is there a solution to this?  I am
>>>
>>>running on
>>>
>>>>a i686 (Athlon XP) 32 bit cpu compiled under gcc-3.4.6.
>>>>
>>>>
>>>>Oct  5 08:27:31 sid kernel: BUG: warning at
>>>>fs/inotify.c:181/set_dentry_child_flags()
>>>>Oct  5 08:27:31 sid kernel:  [<c0182a10>]
>>>
>>>set_dentry_child_flags+0x170/0x190
>>>
>>>>Oct  5 08:27:31 sid kernel:  [<c0182adf>]
>>>
>>>remove_watch_no_event+0x5f/0x70
>>>
>>>>Oct  5 08:27:31 sid kernel:  [<c0182b08>]
>>>
>>>inotify_remove_watch_locked+0x18/0x50
>>>
>>>>Oct  5 08:27:31 sid kernel:  [<c01833dc>] inotify_rm_wd+0x6c/0xb0
>>>>Oct  5 08:27:31 sid kernel:  [<c0183e98>]
>>>
>>>sys_inotify_rm_watch+0x38/0x60
>>>
>>>>Oct  5 08:27:31 sid kernel:  [<c0102d8f>] syscall_call+0x7/0xb
>>>
>>>I don't think it is a known problem. Is it reproduceable?
>>
>>It is a known problem.
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/1209.html
>>
> 
> 
> Thank you for the confirmation.  Please include me in this thread if someone
> finds the answer. This bug seems to occur very frequently on my machine with
> 2.6.18.1 so I have been forced to revert back to 2.6.17.13 until I can fix it.

I haven't got around to looking at it yet, sorry.

It does seem like my inotify scalability patch is involved, however it is
interesting that you cannot reproduce the problem in 2.6.17.13.

I probably won't get around to having a look at it for a while, but if you
would like to speed up the process you could try running a git bisect to
find which patch is making the error trigger for you.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
