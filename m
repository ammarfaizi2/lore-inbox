Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbUJZP7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbUJZP7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUJZP7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:59:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:12459 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261283AbUJZP60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:58:26 -0400
Message-ID: <417E71C1.1080400@osdl.org>
Date: Tue, 26 Oct 2004 08:48:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org> <417D7EB9.4090800@osdl.org> <20041025155626.11b9f3ab.akpm@osdl.org> <417D88BB.70907@osdl.org> <20041025164743.0af550ce.akpm@osdl.org> <417D8DFF.1060104@osdl.org> <Pine.GSO.4.58.0410260319100.17615@mion.elka.pw.edu.pl> <417DBEC1.5000701@osdl.org>
In-Reply-To: <417DBEC1.5000701@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> Yes, that gets further.   :(
>>>>> Maybe I'll just (try) apply the kexec patch to a vanilla kernel.
>>
>>
>>
>> IDE PIO changes are the part of a vanilla kernel.
>>
>> If vanilla kernel (+akpm's fix) works OK then
>> this bug is not mine fault. :)
>>
>>
>>>> I doubt if it'll help much.  It looks like IDE PIO got badly broken.
>>
>>
>>
>> Weird, this code was in -mm for over a month.
>>
>>
>>>> That's something we have to fix - could you work with Bart on it 
>>>> please?
>>>
>>>
>>> Sure.  Bart?
>>
>>
>>
>> I need more data, IDE PIO works fine here.
>>
>>
>>>> How come your disks are running in PIO mode anyway?
>>
>>
>>
>> Maybe disks are runing in DMA mode but some application
>> triggers PIO access (IDENTIFY command, S.M.A.R.T. etc.)...
>>
>>
>>> No idea.
> 
> 
> Andrew made me look.  Duh.  It's because I'm booting with
> ide=nodma.
> 
> So Bart, can you check the noautodma=1 code path?
> And I'll test it again on Tuesday without using ide=nodma.

Booting 2.6.9-mm1 without using "ide=nodma" works well for me.
No other kernel changes.

> 4 oopsen boot logs are (back-to-back) in:
> http://developer.osdl.org/rddunlap/doc/capture-ide.txt
> if you need to see them.

-- 
~Randy
