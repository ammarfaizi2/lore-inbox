Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUJWGQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUJWGQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 02:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUJVRZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:25:49 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:43908 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267380AbUJVRYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:24:40 -0400
Message-ID: <4179425A.3080903@namesys.com>
Date: Fri, 22 Oct 2004 10:24:42 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org>
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>  - reiser4: not sure, really.  The namespace extensions were disabled,
>    although all the code for that is still present.  Linus's filesystem
>    criterion used to be "once lots of people are using it, preferably when
>    vendors are shipping it".  That's a bit of a chicken and egg thing though.
>    Needs more discussion.
>
>  
>
No distro using reiserfs V3 as the default is going to keep doing so 
once reiser4 meets their stability requirements. Reiserfs is used by a 
lot of people, and reiser4 obsoletes it, and the users know that. None 
of the distros have expressed any intent of staying on V3, and they'd be 
silly to do it. Many of them have expressed a desire to use reiser4. 
Next year, indications are that reiser4 usage by distros as their 
default will exceed that which is today possessed by V3. The higher 
performance of V4 is going to increase our market share.

I would like to encourage its inclusion as an experimental filesystem 
BEFORE vendors ship it. I think first putting experimental stuff in the 
kernels used by hackers makes sense. I think it creates more of a community.

I'd like to point out that there is a lot of stuff in the kernel that is 
a lot less stable than reiser4.

That said, inclusion in -mm found some bugs, and we are still testing 
one of the fixes which was a bit deep. I want to finish that testing 
(not more than 7 days) and send you all fixes before asking for inclusion.

Also, Hellwig made a valid point about getting rid of some macros that 
reduce readability (I also hate code that prevents editors finding 
called functions), and zam is working on fixing that.

Lindows is planning on shipping with reiser4 in its next release. I 
would very much like to see our inclusion before that.
