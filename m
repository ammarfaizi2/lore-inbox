Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSICONE>; Tue, 3 Sep 2002 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSICONE>; Tue, 3 Sep 2002 10:13:04 -0400
Received: from [208.33.57.99] ([208.33.57.99]:25048 "EHLO
	radioflyer.ibocradio.com") by vger.kernel.org with ESMTP
	id <S317984AbSICONE>; Tue, 3 Sep 2002 10:13:04 -0400
Message-ID: <3D74C45F.7040006@ieee.org>
Date: Tue, 03 Sep 2002 10:17:03 -0400
From: "D. Sen" <dsen@ieee.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sfr@canb.auug.org.au
CC: "D. Sen" <dsen@ieee.org>, hy0 <hy0@ipoline.com>,
       linux-kernel@vger.kernel.org
Subject: Re: laptop screen apm problems
References: <3D6E418A.6010903@ieee.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Sep 2002 14:17:31.0865 (UTC) FILETIME=[A44CCC90:01C25354]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Not having heard from you, I decided to tinker with apm.c to see if I 
could solve the problem. In particular I compared it with the 2.4.18 
apm.c (I had no problems with 2.4.18). The following seems to fix my 
problem.

Changing line 1786 in apm.c (from the 2.4.19 kernel tree) from:
			idle_period = simple_strtol(str + 12, NULL, 0);

to:
			idle_period = simple_strtol(str + 15, NULL, 0);

solves the problem.

DS

D. Sen wrote:
> Hi Steve,
> 
> I am experiencing some intermittent problems trying to suspend my 
> laptop. The laptop (IBM Thinkpad T30) seems to suspend fine after using 
> 'apm -s' or the Fn+F4 key stroke, but a miniscule of a second later, the 
> LCD screen turns back on with a weird display. Going through the 
> resume-suspend cycle a few times, I can usually get the machine to 
> eventually suspend correctly.
> 
> It seems like not enough time is given for the LCD to turn off correctly.
> 
> In fact, when the problem happens if I do an 'apm -S' (or Fn+F3, to just 
> turn the screen off) and then quickly follow it up using an 'apm -s' or 
> Fn+F4, I usually get the correct suspend behaviour.
> 
> Any ideas?
> 
> Thanks,
> DS
> 


