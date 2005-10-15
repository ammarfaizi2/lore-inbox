Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVJOOah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVJOOah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 10:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVJOOag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 10:30:36 -0400
Received: from 10.ctyme.com ([69.50.231.10]:30152 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1751154AbVJOOag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 10:30:36 -0400
Message-ID: <43511266.7010709@perkel.com>
Date: Sat, 15 Oct 2005 07:29:58 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Forcing an immediate reboot
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe> <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
X-Mail-from: marc@perkel.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anton Altaparmakov wrote:

>On Fri, 14 Oct 2005, Lee Revell wrote:
>  
>
>>On Fri, 2005-10-14 at 18:46 -0700, Marc Perkel wrote:
>>    
>>
>>>Is there any way to force an immediate reboot as if to push the reset 
>>>button in software? Got a remote server that i need to reboot and 
>>>shutdown isn't working.
>>>      
>>>
>>If it has Oopsed, and the "reboot" command does not work, then all bets
>>are off - kernel memory has probably been corrupted.
>>
>>Get one of those powerstrips that you can telnet into and power cycle
>>things remotely.
>>    
>>
>
>If it has sysrq compiled in as root just do:
>
>echo s > /proc/sysrq-trigger
>echo u > /proc/sysre-trigger
>echo s > /proc/sysrq-trigger
>echo b > /proc/sysrq-trigger
>
>This will "sync", "umount/remount read-only", "sync", "immediate hardware 
>reboot".  Should always work...
>
>
>  
>
This worked great. If I had this last night it would probably have saved 
me a trip to San Jose. I especially like that it does the file system 
syncs. I've put it in a script I call "coldboot" and it is now one of my 
tools.

Very useful.

