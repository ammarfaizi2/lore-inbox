Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310503AbSCPRvx>; Sat, 16 Mar 2002 12:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSCPRvn>; Sat, 16 Mar 2002 12:51:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6924 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310503AbSCPRvj>;
	Sat, 16 Mar 2002 12:51:39 -0500
Message-ID: <3C938611.3090008@mandrakesoft.com>
Date: Sat, 16 Mar 2002 12:51:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
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
>I'm not sure what to do about it.  I can handle the duplicate inode case
>more gracefully but it's a heavy duty rewack.
>

Hence my suggestion for a short term solution that's immediately useful 
-- allowing some way to answer "local changes take precedence 100% of 
the time" or "remote changes ..." with a single command.  That was my 
hack solution that I thought would people might find useful when stuck 
with the duplicate-patch situation.

In the command line merge tool, when merging a file-create, "rla" would 
cause the current file conflict, and all future file-create conflicts, 
to be "won" by the remote side -- essentially creating the effect of 
typing "rl" 300 times.
Apply similar logic to the file-rename merge case.  I think the merge 
command I used in 100% of the cases, during that merge, was 'r'.

If you are stuck with the duplicate patch case, as happened here, I just 
want to see the pain eased a bit :)  IMO you can put off the hard 
problem if you make the UI a bit better.

    Jeff




