Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUDZSPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUDZSPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUDZSPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:15:16 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:65471 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262406AbUDZSPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:15:07 -0400
Message-ID: <408D51C4.7010803@namesys.com>
Date: Mon, 26 Apr 2004 11:15:32 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, akpm@osdl.org
Subject: Re: I oppose Chris and Jeff's patch to add an unnecessary	additional
 namespace to ReiserFS
References: <1082750045.12989.199.camel@watt.suse.com>	 <408D3FEE.1030603@namesys.com> <1083000711.30344.44.camel@watt.suse.com>
In-Reply-To: <1083000711.30344.44.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Mon, 2004-04-26 at 12:59, Hans Reiser wrote:
>
>  
>
>
>v4 didn't factor into these decisions because it was still in extremely
>early stages back then (2.4.16 or so).
>  
>
It was clearly indicated then that accessing acls was scheduled for V4 
not V3. 

>  
>
>>I also view 
>>V3 as stable code that should not be disturbed more than minimally 
>>necessary, and I desire for all new functionality to go into V4 (Chris 
>>was also told that before his patch was written).
>>
>>    
>>
>
>You can't release v4 and then expect all the v3 users to disappear
>instantly.  Our users have an expectation that the filesystem they
>choose for their production systems will be reasonably maintained over
>time.
>  
>
The ReiserFS maintainer (me, in case you forgot;-) ) decided what 
release acls would go into, and you disregarded it and wrote an 
implementation that was inconsistent with the one planned.

>I consider supporting the linux standard interfaces for acls and xattrs
>part of being reasonably maintained, and the pending release of v4
>doesn't change that.
>
>  
>
>>Making it possible to unify operating system namespaces was why ReiserFS 
>>was created.  I am not in this for the money.  Pasting in an additional 
>>namespace beyond what Unix had for short term marketing reasons violates 
>>its soul, and I have no desire to provide support for it as it 
>>complicates one feature at a time over 30 years.
>>
>>    
>>
>Disliking the xattr interface is a different discussion.  We
>specifically did not do new and interesting namespace research with the
>v3 patches, we supported the existing apis in as plain and non-intrusive
>a manner possible.
>  
>
Reiser4 was specifically created as a rejection of the xattr api at the 
time that xattrs were first discussed.  It took longer to write it than 
xattrs.  One of your colleagues wrote the xattr api and you/Jeff did the 
ReiserFS portion.  ReiserFS did not go down the xattr path, and declared 
that it would not do so long at the very beginning.  You are continuing 
to try to force us down that path, and now you are claiming that because 
V4 took longer than hacking V3 that means that xattrs are a pre-existing 
api that we are heretically not conforming to.  Love it.

>These patches were not a quick hack,
>
Creating reiser4's unified namespaces was more work and took longer, and 
fragmented namespaces are ugly, that makes xattrs a quick hack.

ReiserFS is release managed.  That means that we schedule when features 
get implemented, and stick to those schedules.  Persons who disregard 
the schedules they were informed of get their release schedule violating 
patches disregarded.  Stable branches do not get new semantics added to 
them just before new major releases with preferred semantics come out.

Please consider contributing to enriching the collection of files that 
act as attributes of other files in V4 instead of pulling your oars in 
the other direction.  If you do, you will be (as usually) a valued 
contributor.

Hans
