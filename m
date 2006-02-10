Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWBJUMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWBJUMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWBJUMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:12:48 -0500
Received: from smtpout.mac.com ([17.250.248.70]:44540 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751371AbWBJUMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:12:47 -0500
In-Reply-To: <200602101439.53394.gene.heskett@verizon.net>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <200602101439.53394.gene.heskett@verizon.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B144E8F3-337C-4B1C-B46C-B97FD3EFBAB1@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]]
Date: Fri, 10 Feb 2006 15:12:32 -0500
To: gene.heskett@verizon.net
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2006, at 14:39, Gene Heskett wrote:
> On Friday 10 February 2006 14:19, Phillip Susi wrote:
>> Marc Koschewski wrote:
>>> I just tried blanking a CD-RW with the latest -git tree. The  
>>> machine just became unresponsive and then froze. When it became  
>>> unresponsive the clock in GNOME still displayed the current time  
>>> but I could not focus any windows anymore. Then I had to hard  
>>> reboot the machine. The logs say nothing. I repeat: nothing.
>>>
>>> Does anyone have similar problems?
>>
>> Instead of rebooting, just wait for the blanking to finish.  My  
>> guess is that your burner and hard drive are both on the same ide  
>> channel, and so you can not access the disk while the burner is  
>> blanking.  If this is the case, put each drive on their own ide  
>> channel.
>
> It takes hard drive access to switch window focus? Yes, thats a  
> question.

Depends on your programs and RAM.  If the program you try to switch  
to (or, say, part of X or your window manage) is swapped out for some  
reason, then yes, changing focus may cause said program to hang until  
it can swap the data in.  Usually that's a small fraction of a  
second, but if your IDE bus is waiting for a burn, then it could be  
the duration of the burn.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



