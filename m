Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265875AbUFISE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUFISE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFISE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:04:27 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38890 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265875AbUFISEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:04:10 -0400
Message-ID: <40C75141.7070408@namesys.com>
Date: Wed, 09 Jun 2004 11:04:49 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>	 <1086784264.10973.236.camel@watt.suse.com>	 <1086800028.10973.258.camel@watt.suse.com>  <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com>
In-Reply-To: <1086801345.10973.263.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Wed, 2004-06-09 at 13:06, Hans Reiser wrote:
>
>  
>
>>>No such luck, the real offender is having tree balance structs on the
>>>stack.  We need to switch to kmalloc for those, which will be mean some
>>>extra work to make sure we don't schedule at the wrong time.
>>>
>>>In other words, not the trivial patch I was hoping for, but I'm cooking
>>>one up.
>>>      
>>>
>
>  
>
>>Can you give me some background on whether this is causing real problems 
>>for real users?
>>    
>>
>
>Especially with the 4k stack option enabled, it will cause real problems
>for real users.  A better change would be to cut down on the size of the
>tree balance struct, but that would be more invasive.  For starters we
>might be able to switch from ints to shorts for some of the arrays.
>
>-chris
>
>
>
>
>  
>
Can you tell me about the "4k stack option"?
