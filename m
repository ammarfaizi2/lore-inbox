Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135585AbRAQTJ7>; Wed, 17 Jan 2001 14:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135584AbRAQTJt>; Wed, 17 Jan 2001 14:09:49 -0500
Received: from mirasta.antefacto.net ([193.120.245.10]:50954 "EHLO
	nt1.antefacto.com") by vger.kernel.org with ESMTP
	id <S135551AbRAQTJd>; Wed, 17 Jan 2001 14:09:33 -0500
Message-ID: <3A65EDE2.4030204@AnteFacto.com>
Date: Wed, 17 Jan 2001 19:09:22 +0000
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org
Subject: Re: Relative CPU time limit
In-Reply-To: <3A65E573.D004302B@baldauf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man setrlimit (or ulimit)
This is per user though, and only related
to user accounting really as you can only
set a limit on the number of CPU seconds
used.

I would also really like the ability
to throttle any processes back to a certain
% of CPU, and extending this to throttling
users to certain CPU limits which would be
useful also.

Obviously you would set it up so that all
available CPU is used, for e.g. if you
had 2 CPU bound processes running and you
allocated 1 to 40% and the other 60%, when
either terminates the other should increase
to the available CPU (I can't see any reason
why you would forceably limit a process' CPU
usage if there was free CPU).

Could the current scheduling logic that uses
the nice value of a process, do this, and all
I would have to do is have a % specifying wrapper
around this?

Any other ideas or will I get hacking..

Padraig.

Xuan Baldauf wrote:

> Hello, (maybe a FAQ, but could not find this question)
> 
> is it possible with linux2.4 to limit the relative CPU time
> per process or per UID? I saw something like this about 5
> years ago on solaris machines, but I have not access to
> solaris machines anymore. I do not mean limiting the
> absolute CPU time (e.g. "the process should run 20minutes at
> maximum and shall be killed after that time), but the
> relative CPU time (e.g. "apache should consume at most 80%
> of my servers CPU time and shall be throttled if it was to
> consume more").
> 
> Thanx,
> Xuân. :-)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
