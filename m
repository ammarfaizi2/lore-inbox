Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266713AbUFYL57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266713AbUFYL57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 07:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUFYL57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 07:57:59 -0400
Received: from mail.dynextechnologies.com ([65.120.73.98]:8176 "EHLO
	mail.dynextechnologies.com") by vger.kernel.org with ESMTP
	id S266713AbUFYL5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 07:57:53 -0400
Message-ID: <40DC1339.7030205@dynextechnologies.com>
Date: Fri, 25 Jun 2004 07:57:45 -0400
From: "Fao, Sean" <Sean.Fao@dynextechnologies.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: alan <alan@clueserver.org>, linux-kernel@vger.kernel.org,
       Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
References: <20040624220318.GE20649@elf.ucw.cz> <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org> <20040625001545.GI20649@elf.ucw.cz>
In-Reply-To: <20040625001545.GI20649@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 11:57:53.0079 (UTC) FILETIME=[A5344470:01C45AAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>A better option in this case is to reduce the default size of Mozilla's 
>>cache or expand the size of the quota for each user to deal with the added 
>>space requirements.
>>
>>If you are concerned about disk usage from caches, you can always create 
>>a script that removes the cache(s) when the user logs out.
>>    
>>
>
>That's not the right thing.. that way you loose caching effects around
>logins even when there's plenty of space.
>
>There's quite a lot of data -- at least on my systems -- that can be
>removed with "only" loss of performance...
>
>1) browser caches
>
>2) package lists, downloaded packages
>
>3) object files
>
>heck, if you know you have reliable network connection 4), you could
>even mark stuff like /usr/bin/mozilla elastic, and re-install it from
>the network when it is needed... Doing anything more complex than 1)
>requires extensive changes all around the kernel and userland, and
>you'd probably not call that system unix any more.
>  
>
All the suggested benefits listed above could easily be implemented in a 
script.  For instance, one could design a script that checks the amount 
of disk space at logout.  If the amount of disk space remaining is less 
than X (where X is value predefined by an administrator), the script 
could _suggest_ that corrective action be taken and allow the *user* to 
_decide_ what he/she wants to delete/move.

In a workstation environment, my honest opinion is that quota's are set 
entirely too low if you're running that close to your limit.  On a 
server, I do not see deleting files at the decision of the OS, to be 
beneficial.  Nor do I see any reason to develop the suggested FS to 
implement what should be taken care of by a knowledgeable administrator.

The idea of an elastic file system is interesting until you start 
considering how it would be implemented and what affects it would have 
in a production environment.

Sean
