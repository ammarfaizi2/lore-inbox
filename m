Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTJaVXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 16:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTJaVXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 16:23:19 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:27720 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S263614AbTJaVXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 16:23:17 -0500
Message-ID: <3FA2D2C1.90303@planet.nl>
Date: Fri, 31 Oct 2003 22:23:13 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason (added more info)
References: <3F9BC429.6060608@planet.nl> <3F9D0BBB.9080600@aitel.hist.no>
In-Reply-To: <3F9D0BBB.9080600@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear All,

Thanks for all the help. I reread all the emails sent and looked into 
cron. The dug into the logs and found some interesting stuff in the 
maillog and messages. Sendmail apperantly needed procmail to work 
properly with the latest version. This solved my issue.

Thanks everybody for your help. This again proves that I'm just a newbee 
in the debuging of problems on Linux. OS/400 seems to be more my area of 
expertise ;-)

Stef

Helge Hafting wrote:

> Stef van der Made wrote:
>
>>
>> On my AMD athlon system with 512MB memory I sometimes get a lot of 
>> disk activity the activity normaly lasts for about 10 seconds and 
>> after that the disk stays relativily quiet as expected with the load 
>> on the system. When I look into top I don't see any programs that 
>> could explain the disk activity. The system is in most cases not 
>> using any swap.
>>
> Try finding out what is causing this.
> Have a "vmstat 1" running.  Break it after this
> disk activity starts.  You should be able to
> see wether it is normal io or swap.
>
> Also have a "top -d 1" running.  A normal
> process issuing lots of io will probably
> show up here too.  "ps aux" during
> the activity might also be a good idea.
>
> Note that such behaviour isn't necessarily unusual.
> Perhaps cron started something that needed lots
> of reads to start?  Perhaps you got a bunch of emails?
> Email software often use synchronous writes, so they won't
> loose any of your mail even in case of a crash.
> This synchronous io makes for _lots_ of disk seeking.
> Email filters (for spam and other purposes) may make this even worse, 
> with email messages being written synchronously several times.
> If you use "fetchmail" started by cron - see if these disk bursts
> correspond with mail fetching.
>
> Helge Hafting
>
>

