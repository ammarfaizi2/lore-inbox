Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310514AbSCPSGN>; Sat, 16 Mar 2002 13:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310515AbSCPSGE>; Sat, 16 Mar 2002 13:06:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21004 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310514AbSCPSFw>;
	Sat, 16 Mar 2002 13:05:52 -0500
Message-ID: <3C938966.3080302@mandrakesoft.com>
Date: Sat, 16 Mar 2002 13:05:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <20020316093832.F10086@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>>I think a fair question would be, is this scenario going to occur often? 
>> I don't know.  But I'll bet you -will- see it come up again in kernel 
>>development.  Why?  We are exercising the distributed nature of the 
>>BitKeeper system.  The system currently punishes Joe in Alaska and 
>>Mikhail in Russia if they independently apply the same GNU patch, and 
>>then later on wind up attempting to converge trees.
>>
>
>Indeed.  So speak in file systems, because a BK package is basically a file
>system, with multiple distributed instances, all of which may be out of
>sync.  The problems show up when the same patch is applied N times and 
>then comes together.  The inodes collide.  Right now, you think that's
>the problem, and want BK to fix it.  We can fix that.  But that's not 
>the real problem.  The real problem is N sets of diffs being applied
>and then merged.  The revision history ends up with the data inserted N
>times.
>

Another thought, that I'm betting you laugh at me for even suggesting :)

Don't insert the data N times.  Give the user the option to say that one 
or more changesets are actually the same one.  In filesystem speak, 
unlink a file B which is a user-confirmed duplicate of file A, and 
re-create file B as a symlink to file A.  Or just unlink file B without 
the symlink, whichever metaphor suits you better.  :)

Yes it is "altering history"... but... OTOH the user has just told 
BitKeeper, in no uncertain terms, that he is altering history only to 
make it more correct.

 From a user interface perspective, the user would pick one of N 
changeset comments to be considered the "real" one.

    Jeff





