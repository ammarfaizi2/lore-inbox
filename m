Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273792AbRIRAvA>; Mon, 17 Sep 2001 20:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273794AbRIRAuu>; Mon, 17 Sep 2001 20:50:50 -0400
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:8976 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S273792AbRIRAul>;
	Mon, 17 Sep 2001 20:50:41 -0400
Message-ID: <3BA69D84.3020909@foogod.com>
Date: Mon, 17 Sep 2001 18:04:04 -0700
From: Alex Stewart <alex@foogod.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Xavier Bestel <xbestel@aplio.fr>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Forced umount (was lazy umount)
In-Reply-To: <Pine.LNX.4.21.0109171144210.1357-100000@penguin.homenet> 	<3BA68562.6030806@foogod.com> <1000768993.20059.5.camel@nomade>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

> le mar 18-09-2001 at 01:21 Alex Stewart a écrit :
> [...]
> 
>>I see no reason why a properly functioning system should ever need to 
>>truly force a umount.  Under normal conditions, if one really needs to 
>>do an emergency umount, it should be possible to use fuser/kill/etc to 
>>clean up any processes using the filesystem from userland and then 
>>perform a normal umount to cleanly unmount the filesystem in question 
[...]

> 
> Imagine you have a cdrom mounted with process reading it. You may want
> to eject this cdrom without killing all processes, but just make them
> know that there's an error somewhere, go read something else.
> So it won't kill your shells, Nautilus/Konqueror, etc.


Ok, I should have made my terms more clear.  I see no reason why a 
properly functioning system should *need* to force a umount.  There's a 
difference between "need" and "want".  What you're talking about is a 
convenience (and I admitted that the patch would make some things more 
convenient), but not a necessity.  With decently written software you 
should be able to simply go to the relevant programs and tell them to 
stop using the filesystem before you unmount it.  All this does is make 
that process a little less tedious.

My point was that I agree that the proposed patch is nice, and I'd like 
to see something like it included, but considering it's primarily a 
convenience rather than addressing something you can't do other ways, I 
think it can probably wait until 2.5 at this point (at least assuming 
2.6 doesn't take as long to get out the door as 2.4 did).  As far as 
fixing the real problem I was bringing up originally (which the patch 
doesn't do), I also think it'll require a large enough change that 
although I'd like to see it sooner, I can understand holding off until 2.5.

-alex

