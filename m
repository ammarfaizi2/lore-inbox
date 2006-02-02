Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWBBTQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWBBTQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWBBTQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:16:46 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:37830 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750832AbWBBTQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:16:46 -0500
Message-ID: <43E25ADF.7070903@tmr.com>
Date: Thu, 02 Feb 2006 14:17:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: gmack@innerfire.net, diablod3@gmail.com, schilling@fokus.fraunhofer.de,
       bzolnier@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux try #2
References: <200601302043.56615.diablod3@gmail.com>	 <20060130.174705.15703464.davem@davemloft.net>	 <Pine.LNX.4.64.0601310609210.2979@innerfire.net>	 <20060131.031817.85883571.davem@davemloft.net> <787b0d920601312049n313364a1q8a41e10c3cda98e0@mail.gmail.com>
In-Reply-To: <787b0d920601312049n313364a1q8a41e10c3cda98e0@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On 1/31/06, David S. Miller <davem@davemloft.net> wrote:
> 
> 
>>Someone remind me why the whole world is a prisoner to Joerg's cd
>>burning program?
>>
>>Anybody can write their own, and if Joerg is a pain to work with that
>>is a double extra incentive for this other implementation to be
>>written.
>>
>>In fact I'm very surprised this hasn't happened already.
> 
> 
> It has happened, many times, but sustaining such a project is
> very difficult. The obstacles are numerous:
> 
> All the GUI apps parse cdrecord output. The output is somehow
> even messier than the recent /proc/*/smaps abomination. It is
> thus difficult to change or replace cdrecord. One of the major
> GUI apps appears to be written by Joerg's real-life non-Internet
> friend, who naturally refuses any patches to eliminate the need
> for cdrecord.
> 
> Joerg is a Fraunhofer employee. That gives him connections to
> many hardware companies. (and the RIAA, MPAA, Sony, Disney...)
> One may wonder if this is both blessing and curse.
> 
> Forking means dealing with a giant pile of messy and ugly code.
> The coding conventions are... interesting... and this code has
> to run setuid. One had better be really careful making changes.
> Most people are clueless about setuid code.
> 
> Starting fresh means rediscovering firmware bugs, of which there
> are many. Things may be getting somewhat better though, with the
> old pre-standard interfaces hopefully dying out. Getting the most
> out of the hardware will require lots of device-specific code.
> 
> Joerg gets the hardware.
> 
> There are all sorts of funky formats. I've only ever heard of
> mixed audio+data CDs for circa-1995 games and Sony spyware, but
> maybe there are decent people who actually create these things.
> In theory, somebody might be making multi-session CDs. Who knows?

Not just in theory, I get notes from people saying they use addir for 
backups, which is why I wrote it, because I change ~50MB/day and one CD 
will hold all the change. So addir is like growisofs with some 
additional bells and whistles I found useful, like taking a list of 
files changed taoday from stdin (find) and adding them to the end of the 
CD, preserving or renaming directory names, etc.

http://www.tmr.com/~public/source/addir if you want to see an example.

I used the mixed audio and data a few times, I'm sure there are folks 
who use it regularly. cdrecord is full function, and continues to 
support new vendors and models, work around firmware bugs etc. A real 
replacement is going to be a lot of ongoing work.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
