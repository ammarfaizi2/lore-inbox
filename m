Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbVIORWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbVIORWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbVIORWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:22:08 -0400
Received: from smtpout.mac.com ([17.250.248.46]:42471 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030546AbVIORWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:22:07 -0400
In-Reply-To: <43293591.19922.2890E4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <43286E4B.1070809@mvista.com> <43293591.19922.2890E4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2088723E-06A0-40ED-A51D-19316AE57ECA@mac.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       yoshfuji@linux-ipv6.org, Roman Zippel <zippel@linux-m68k.org>,
       joe-lkml@rameria.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: NTP leap second question
Date: Thu, 15 Sep 2005 13:21:25 -0400
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15, 2005, at 02:49:21, Ulrich Windl wrote:
> On 14 Sep 2005 at 11:54, john stultz wrote:
>> If I recall, leapsecond implementations are a pretty contentious  
>> issue.  Some folks have suggested having the kernels note the  
>> leapsecond and slew the clock internally. This sounds nicer then  
>> just adding or
>
> No! Never slew a leap second: It will take too long! It's all over  
> after one second. If you slew, you time will be incorrect for an  
> extended time.

I think he said "It's a contentious issue", and "Some have  
suggested".  No need to get your underwear in a bunch over it.  There  
are arguments for both sides.  Besides, it's not like it matters much  
in the grand scheme of things, it's only a second.  With the current  
proposals, the leap-second-slewing would only be in effect for 1000  
seconds, and you'd never be very far off true time (The simplest  
implementation is one second off, if you add one bit of state you'll  
only ever be a half-second off).  If you're willing to make it a bit  
slower and a bit more code, you could even make the slewing nonlinear  
with a continuous derivative, so it's only in place for ~20 seconds,  
and only changes rapidly near the leapsecond boundary itself.  On the  
other hand, if your box is running a nuclear reactor, you might want  
to do a bit more verification, but Linux isn't certified for that  
anyways!! :-D

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



