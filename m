Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265852AbUFIRFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUFIRFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUFIRFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:05:41 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:31216 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265852AbUFIRFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:05:36 -0400
Message-ID: <40C74388.20301@namesys.com>
Date: Wed, 09 Jun 2004 10:06:16 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>	 <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com>
In-Reply-To: <1086800028.10973.258.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Wed, 2004-06-09 at 08:31, Chris Mason wrote:
>  
>
>>On Wed, 2004-06-09 at 08:22, Jörn Engel wrote:
>>    
>>
>>>reiserfs has some stack-hungry functions as well.  Could you put them
>>>on a diet?
>>>
>>>      
>>>
>>Yes, we should be able to fix things by getting rid of some of the
>>inlines in a few spots (some funcs are much too large for inlining). 
>>I'll send a patch out this morning.
>>    
>>
>
>No such luck, the real offender is having tree balance structs on the
>stack.  We need to switch to kmalloc for those, which will be mean some
>extra work to make sure we don't schedule at the wrong time.
>
>In other words, not the trivial patch I was hoping for, but I'm cooking
>one up.
>
>-chris
>
>
>
>
>  
>
Can you give me some background on whether this is causing real problems 
for real users?
