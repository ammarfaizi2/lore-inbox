Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWH2JQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWH2JQC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWH2JQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:16:01 -0400
Received: from szamitogep.hu ([62.77.196.4]:25007 "EHLO www.szamitogep.hu")
	by vger.kernel.org with ESMTP id S932224AbWH2JQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:16:00 -0400
Message-ID: <4830.213.163.11.81.1156842958.squirrel@www.dunaweb.hu>
In-Reply-To: <44F400EA.5020506@aitel.hist.no>
References: <3557.213.163.11.81.1156838596.squirrel@www.dunaweb.hu>
    <44F400EA.5020506@aitel.hist.no>
Date: Tue, 29 Aug 2006 11:15:58 +0200 (CEST)
Subject: Re: How to determine whether a file was opened O_DIRECT?
From: =?iso-8859-2?Q?B=F6sz=F6rm=E9nyi_Zolt=E1n?= <zboszor@dunaweb.hu>
To: "Helge Hafting" <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Böszörményi Zoltán wrote:
>> Hi,
>>
>> I would like to run some diagnostics on a database
>> process and I would like to know what flags it used
>> for opening its files. Is there any way to get this info?
>>
>> Thanks in advance,
>> Zoltán Böszörményi
>>
> 1. Look at the source code for the database - if you have it.

Unfortunately not.

> 2. Run your database under strace, then search the voluminous
>     output for "open" calls and look at the flags.

I can't do that, it's a production machine. But ...

> 3. Patch your kernel to "printk" information whenever
>     someone opens with O_DIRECT.

... this should have been obvious. :-) Thanks.

I just thought a command like fuser
may already exists to give me this info.
Or something under /proc/PID/fd.

>
> Helge Hafting
>

