Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUHBQwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUHBQwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUHBQwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:52:07 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:45718 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266630AbUHBQve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:51:34 -0400
Message-ID: <410E710E.20004@acm.org>
Date: Mon, 02 Aug 2004 11:51:26 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IPMI watchdog question
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de> <Pine.LNX.4.58.0408021119320.31915@praktifix.dwd.de> <410E5F46.2030005@acm.org> <200408021829.18228.arekm@pld-linux.org>
In-Reply-To: <200408021829.18228.arekm@pld-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:

>On Monday 02 of August 2004 17:35, Corey Minyard wrote:
>  
>
>>The IPMI watchdog has never supported writing "V" to disable it.  It's a
>>mixed bag with the other watchdogs, some do and some don't, but I can
>>certainly add that function.  Or even better, I'd be happy to take a
>>patch :).
>>    
>>
>
>Like this one (untested beside compilation) below?
>
>btw. other watchdog drivers use:
>
>	if(test_and_set_bit(0, &wdt_is_open))
>                return -EBUSY;
>
>while ipmi does just:
>	ipmi_wdog_open = 0;
>
>should it also use bit operations or setting =0 is just fine?
>
You are correct, a test and set operation is really needed.

>
>Patch:
>
>- support disabling watchdog by writting ,,V'' to device.
>- unify printk()
>
>Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>
>  
>
Your patch looks very good.  Could you add the test and set change, 
too?  Then I think it is ready to go in.

-Corey

