Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVADXy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVADXy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVADXyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:54:07 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55691 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262412AbVADXv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:51:56 -0500
Message-ID: <41DB2BF3.2010103@tmr.com>
Date: Tue, 04 Jan 2005 18:51:15 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Thomas Graf <tgraf@suug.ch>, "Theodore Ts'o" <tytso@mit.edu>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050104031229.GE26856@postel.suug.ch><20050104031229.GE26856@postel.suug.ch> <20050104053348.GB19945@alpha.home.local>
In-Reply-To: <20050104053348.GB19945@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

> The problem with -rc is that there are two types of people :
>   - the optimists who think "good, it's already rc. I'll download it and
>     run it as soon as it's released"
>  - the pessimists who think "I killed my machine twice with rc, let's leave
>    it to other brave testers".
> 
> These two problems are solvable with the same solution : no rc anymore.

How does that help? The 2nd group won't D/L the -bk versions either, I 
certainly can see the logic in that.

Someone said we used to have a development and stable series and only 
the best tested stuff from devel made it into stable. Then spoiled it by 
saying that stable and -mm did that now. The problem is that akpm is 
wearing both hats, he tries stuff in -mm, then decides it's stable for 
the mainline. There's no "cooling off" period for mainline when it only 
gets fixes, and no 2nd set of eyes doing triage between the fix and the 
feature.

I would really like to see:
a - more frequent releases in mainline
b - point releases with ONLY fixes (ie. 2.6.11.1, etc)

For (a) pick a release date, say the first and 16th of every month. On 
that date apply the latest -bk, any known fixes to problems (see below) 
and call it 2.6.N+1.

For (b) a fix would be defined as a failure in an existing feature which 
causes correct operation without side effects. NOT "works better" but 
only to go from "doesn't work" to "works." Strict adherence to the "if 
it ain't broke don't fix it" rule. I would expect the average number to 
be zero, and only rarely more than one.

That would keep people from having to wait more than a few weeks for a 
new feature or enhancement, or they could go to the -bk, and would give 
a clearly identified fix (only if needed) which is unlikely to break 
anything.

I expect this to be ignored or disparaged like all other suggestions 
that anything resembling stability is needed.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
