Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVAWW2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVAWW2c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 17:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVAWW2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 17:28:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:54155 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbVAWW20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:28:26 -0500
Message-ID: <41F42329.8020808@osdl.org>
Date: Sun, 23 Jan 2005 14:20:25 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryce Harrington <bryce@osdl.org>
CC: Chris Wright <chrisw@osdl.org>, dev@osdl.org, linux-kernel@vger.kernel.org,
       stp-devel@lists.sourceforge.net
Subject: Re: Kernel 2.6.11-rc1/2 goes Postal on LTP
References: <Pine.LNX.4.33.0501221125140.30167-100000@osdlab.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0501221125140.30167-100000@osdlab.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce Harrington wrote:
> On Fri, 21 Jan 2005, Chris Wright wrote:
> 
>>* Bryce Harrington (bryce@osdl.org) wrote:
>>
>>>Well, I'm not having much luck.  strace isn't installed on the system
>>>(and is giving errors when trying to compile it).  Also, the ssh session
>>>(and sshd) quits whenever I try running the following growfiles command
>>>manually, so I'm having trouble replicating the kernel panic manually.
>>
>>Sounds very much like oom killer gone nuts.
>>
>>
>>># growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
>>>
>>>Anyway, if anyone wants to investigate this further, I can provide
>>>access to the machine (email me).  Otherwise, I'm probably just going to
>>>wait for -rc2 and see if the problem's still there.
>>
>>Wait no longer, it's here ;-)
> 
> 
> Hmm, still the kernel is going nutso.  LTP and everything else on the
> system is getting killed, including the test manager process.
> 
> Below's a bit more info scraped from the console.  This is from a run on
> RH 9.0.  It looks like LTP got through 722 of its 2270 tests before the
> kernel goes postal on it.  This time it got through all the growfile
> commands before it died (see bottom of this post), however it looks like
> the same growfile cmd I reported earlier is the one causing the problem.
> 
> When I run:
> 
> mkfifo gffifo18;
> strace growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18 &> /tmp/growfiles_strace_log.txt
> 
> The following happens:
> 
> * I get this strace log:  http://developer.osdl.org/bryce/growfiles_strace_log.txt
> * The ssh session dies and returns to login prompt
> * A bunch of stuff similar to below is spewed to console
> 
> Bryce
> 
> 
> Console
> =======
> ...snip...
> Memory: 905212k/917504k available (2211k kernel code, 11840k reserved,
> 871k data, 192k init, 0k highmem)
> ...snip...

Yes, about the same for me on P4-UP with 1 GB RAM (home PC :).
No X running, just console and some daemons.

-- 
~Randy
