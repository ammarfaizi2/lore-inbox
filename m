Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUHBPhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUHBPhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHBPhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:37:22 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:21957 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266568AbUHBPfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:35:41 -0400
Message-ID: <410E5F46.2030005@acm.org>
Date: Mon, 02 Aug 2004 10:35:34 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IPMI watchdog question
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de> <200407281129.22431.arekm@pld-linux.org> <Pine.LNX.4.58.0407281021530.31636@praktifix.dwd.de> <200407281246.27304.arekm@pld-linux.org> <Pine.LNX.4.58.0408021119320.31915@praktifix.dwd.de>
In-Reply-To: <Pine.LNX.4.58.0408021119320.31915@praktifix.dwd.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IPMI watchdog has never supported writing "V" to disable it.  It's a 
mixed bag with the other watchdogs, some do and some don't, but I can 
certainly add that function.  Or even better, I'd be happy to take a 
patch :).

-Corey

Holger Kiehl wrote:

>On Wed, 28 Jul 2004, Arkadiusz Miskiewicz wrote:
>
>  
>
>>On Wednesday 28 of July 2004 12:33, Holger Kiehl wrote:
>>
>>    
>>
>>>>Do you have CONFIG_WATCHDOG_NOWAYOUT enabled?
>>>>        
>>>>
>>>No this is not set. Must this be set? Actually I want that one can stop the
>>>watchdog gracefully. And this is done by writting a 'V' to /dev/watchdog,
>>>correct?
>>>      
>>>
>>Without CONFIG_WATCHDOG_NOWAYOUT (or nowayout=1 module option added by my 
>>patch just sent to lkml) when /dev/watchdog is closed then watchdog timer is 
>>disabled.
>>
>>    
>>
>Ok, with CONFIG_WATCHDOG_NOWAYOUT the system gets it reset. However now
>there is no save way to stop the watchdog gracefully. It no longer honors
>the magic letter 'V', but looking at the code of ipmi_watchtog.c I could
>find no place where it looks for the magic character 'V'. So I am still not
>sure what to do. The reason why I killed the process writting the heartbeat
>was that I just wanted to see if the watchdog does work. Or is there a
>simpler way to simulate a system hangup?
>
>Thanks,
>Holger
>  
>


