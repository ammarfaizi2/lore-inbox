Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTHVUpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTHVUpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 16:45:43 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:3247 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263679AbTHVUpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 16:45:35 -0400
Message-ID: <3F468181.5020605@sbcglobal.net>
Date: Fri, 22 Aug 2003 15:48:01 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O17int
References: <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net> <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <200308210723.42789.kernel@kolivas.org> <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net> <5.2.1.1.2.20030822072356.01a22be0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030822072356.01a22be0@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, those are very bad stalls, much worse than the normal temporary 
stalls when something is running in the background.  I think part of 
that can be attributed to mozilla, which likes to do very little for a 
while, then jump up to 5% for a little bit and then up to 35% for 5 
seconds or so. 
With something running in the background, things get very bad.  Those 
vmstat were supposed to be reported at 5 second intervals, but they were 
not being reported at the rate during the problem.  Those represent 
about 5 minutes of stalling.  I could live with a short stall, but 5 
minutes where the computer barely takes input is crazy.  X becomes 
totally unresponsive to the point I cannot switch to a VT. 

I started a shutdown one time with the acipd daemon watching for power 
button events.  It took 1 hour 30 minutes from the time it said that it 
was shutting down (I could hear the beep from the shutdown process) to 
the point I got to "Stopping at daemon" which is barely into the 
shutdown cycle.  Even then I waited another 10 minutes for it to 
complete the shutdown and it never did.  All I was doing there was 
compiling in a gnome-terminal, and had just clicked on a bug-buddy 
window to get it to show debugging information.  I couldn't get to a VT 
so I wasn't able to get a vmstat log of that one. 

Even if this is due to a bad interaction between a program and X, it 
shouldn't be able to bring the system to its knees.

Kernel version:
2.6.0-test3-mm2 + O16.3int



Mike Galbraith wrote:

>
> Those high interrupt counts are all stalls?  What kernel is that?
>

