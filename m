Return-Path: <linux-kernel-owner+w=401wt.eu-S1753990AbWLXAr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbWLXAr5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 19:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbWLXAr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 19:47:57 -0500
Received: from alnrmhc13.comcast.net ([204.127.225.93]:60649 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbWLXAr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 19:47:56 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Dec 2006 19:47:56 EST
Message-ID: <458DCCE2.3060605@comcast.net>
Date: Sat, 23 Dec 2006 19:42:10 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: evading ulimits
References: <458C4CEF.3090505@comcast.net> <Pine.LNX.4.61.0612240111250.20280@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612240111250.20280@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan Engelhardt wrote:
>> I've set up some stuff on my box where /etc/security/limits.conf
>> contains the following:
>>
>> @users          soft    nproc           3072
>> @users          hard    nproc           4096
>>
>> I'm in group users, and a simple fork bomb is easily quashed by this:
>>
>> bluefox@icebox:~$ :(){ :|:; };:
>> bash: fork: Resource temporarily unavailable
>> Terminated
>>
>> Oddly enough, trying this again and again yields the same results; but,
>> I can kill the box (eventually; about 1 minute in I managed to `/exec
>> killall -9 bash` from x-chat, since I couldn't get a new shell open)
>> with the below:
> 
> Note that trying to kill all shells is a race between killing them all first
> and them spawning new ones everytime. To stop fork bombs, use killall -STOP
> first, then kill them.
> 

Yes I know; the point, though, is that they should die automatically
when the process count hits 4096.  They do with the first fork bomb;
they keep growing with the second, well past what they should.
> 
> 	-`J'

-- 
    We will enslave their women, eat their children and rape their
    cattle!
             -- Bosc, Evil alien overlord from the fifth dimension
Anti-Spam:  https://bugzilla.mozilla.org/show_bug.cgi?id=229686
