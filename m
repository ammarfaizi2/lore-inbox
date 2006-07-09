Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWGIGHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWGIGHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 02:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWGIGHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 02:07:09 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:33419 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1161094AbWGIGHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 02:07:07 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.16.109):SA:0(-102.4/1.7):. Processed in 1.476677 secs Process 32605)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Chase Venters" <chase.venters@clientec.com>
Cc: "Robert Hancock" <hancockr@shaw.ca>, <kernelnewbies@nl.linux.org>,
       <linux-newbie@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Sun, 9 Jul 2006 11:41:22 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMGEEJDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-reply-to: <200607090018.45972.chase.venters@clientec.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>
>> I tried with the /proc/sys/vm/overcommit_memory=2 and the system refused
to
>> load the program altogether.
>>
>> In this scenario is making overcommit_memory=2 a good idea?
>
>(Good mailing list practices ask you not to top-post - that is, make your
>reply text follow the text you are replying other than appearing before it,
>as I demonstrate here:)
>
Hope this time round I am following the std practice. :-)
>
>Well, how much memory do you have? Does the application actually need more
>memory than your system can provide? If this is the case, there isn't going
>to be any fix except add more memory. Your choices are:
>
>1. Let the OOM killer sacrifice processes because you don't have enough
memory
>2. Disable VM overcommit so that the OOM killer doesn't get engaged
(rather,
>the application's attempt to grab the memory will fail)
>3. Add more memory, don't mess with the overcommit sysctl, and watch things
>work nicely :P

>Are you sure it's not a memory leak? Does the application work on a freshly
>booted system?

I have a total of 16 MB RAM. My main concern is that I was running the same
set of applications earlier on linux-2.4.19-rmk7-pxa1 and didn't get any out
of memory. I am running the same application and get the OOM, though the
appearance is not uniform, at times it comes on a freshly booted system and
at times it didn't come when the system is on overnight.... Why I am getting
here??? Is there any problem with linux-2.6.13?

I have tried to check the application for memory leak with no success. There
seems to be no memory leak.

>Thanks,
>Chase

Regards,
Abu.

