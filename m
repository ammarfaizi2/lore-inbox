Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUANNcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266320AbUANNcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:32:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:12237 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266317AbUANNcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:32:18 -0500
Message-ID: <400544D8.5090005@namesys.com>
Date: Wed, 14 Jan 2004 16:32:08 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: kmail slowdown on 2.6.* +reiserFS (v3)
References: <200401112109.22027.ciaby@autistici.org>	 <20040111182739.0686fbee.akpm@osdl.org> <1074086445.32706.1013.camel@tiny.suse.com>
In-Reply-To: <1074086445.32706.1013.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Sun, 2004-01-11 at 21:27, Andrew Morton wrote:
>  
>
>>Ciaby <ciaby@autistici.org> wrote:
>>    
>>
>>>I all!
>>>I've recently upgraded from 2.4 to 2.6 and I've noticed a strange thing:
>>>on the 2.4 kernel, kmail run decently (i've an old k6-200).
>>>On the 2.6 kernel, kmail slowdown and take a very long time to read a mailbox.
>>>I think something changed in the reiserFS during this time...
>>>I'm not the only experiencing this problem, read this:
>>>http://kerneltrap.org/node/view/1844
>>>      
>>>
>>A buglet in kmail was tripped up by some optimisations which went into
>>reiserfs.
>>
>>Upgrading kmail should fix it up.  Or mount the reiserfs filesystems with
>>the `nolargeio=1' mount option.
>>    
>>
>
>Actually, we've hit other problems with v3 largeio, it can confuse rpm
>badly.  The real bug is apparently in bdb, the larger io size suggested
>by the filesystem lead bdb to corrupt its own files.  I spent some time
>neck deep in the db code but couldn't track the problem down.
>
>I seem to remember the XFS folks hitting exactly the same bug.
>
>Hans, can I talk you into having v3 export an io size of 4k to userspace
>again?  Applications that send large ios would still use Oleg's
>optimized file write paths.
>
>-chris
>
>
>
>
>  
>
why is it you don't want to "fix" bdb to lie to itself about the result 
of statfs?

-- 
Hans


