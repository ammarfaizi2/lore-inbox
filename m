Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVCAHHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVCAHHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 02:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVCAHHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 02:07:14 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:24293 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261274AbVCAHHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 02:07:06 -0500
Message-ID: <42241491.2060303@andrew.cmu.edu>
Date: Tue, 01 Mar 2005 02:06:57 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <20050228134410.GA7499@bytesex><20050228134410.GA7499@bytesex> <42232DFC.6090000@andrew.cmu.edu> <4223A5C3.6010000@tmr.com>
In-Reply-To: <4223A5C3.6010000@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it was a line spike since one of the video cards that went 
bad didn't have a video cable attached to it.  It could be the computer, 
but that one hasn't given us a problem for the almost five years we've 
had it.  If I did cause it though with my "buggy program of doom", that 
shouldn't reflect on using well tested/well behaved V4L2 apps.  At most 
I might say 2.6.10+bttv might not be a good development platform for new 
V4L2 apps.  I'll investigate more and hopefully have an better answer soon.

The card= option didn't help in my case since my card is not in the 
list; For thess cards we went off the reccomendation of other people 
doing machine vision in Linux; Next time I guess we'll go name brand 
again...

We have another machine with clones of the "Matrox Meteor I", which has 
"Intel SAA7116" chips on it.  It doesn't seem to be supported in 2.6 
however by any of the various SAA* drivers; In 2.4 there was an 
out-of-tree drive here:
	http://www.k-team.com/software/linux.htmldriver
If there is a way to get these cards working I could use them to debug 
the "program of doom", and thus find the bugs that potentially caused 
the original problem with the bttv cards.  Right now said program is 22k 
lines with 600 lines of V4L interaction, so its hardly an efficient test 
case to tell us where to look in the driver.  Another option is go buy 
Conexant 2388x derivatives for the debugging, but I'm worried they may 
be similar enough to bttv chips that the same problem might be triggered.

  - Jim Bruce

Bill Davidsen wrote:
> James Bruce wrote:
> 
>> Well, are there any theories as to why it would work flawlessly, then 
>> after a hard lockup (due to what I think is a buggy V4L2 application), 
>> that the cards no longer work?  That was with 2.6.10, but after they 
>> started failing I tried 2.6.11-rc5 and it doesn't work either.  By the 
>> way, I sent the wrong output; what I sent was from 2.6.11-rc5.  The 
>> 2.6.10 output is below, and looks similar except for generating a 
>> different error message.
> 
> Is there any chance that the lockup was related to an external event, 
> like a spike on the line to the video? Or any other outside event? It 
> seems like a very odd failure mode, but since I'm about to drop in a 
> bttv card and digitize about a hundred old tapes, I'd like to know.
> 
> Did you try the "card=" suggestion?
