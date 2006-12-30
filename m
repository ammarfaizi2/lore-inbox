Return-Path: <linux-kernel-owner+w=401wt.eu-S1754338AbWL3LJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbWL3LJ2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 06:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbWL3LJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 06:09:28 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:42305 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbWL3LJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 06:09:27 -0500
Date: Sat, 30 Dec 2006 12:07:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Want comments regarding patch
In-Reply-To: <E1H0Rec-00011Y-55@be1.lrz>
Message-ID: <Pine.LNX.4.61.0612301206090.26556@yvahk01.tjqt.qr>
References: <7x8ul-7NU-7@gated-at.bofh.it> <7x8E5-80F-13@gated-at.bofh.it>
 <7xdkq-7tB-25@gated-at.bofh.it> <7xjSQ-1fR-13@gated-at.bofh.it>
 <7xn0j-6rY-7@gated-at.bofh.it> <E1H0Rec-00011Y-55@be1.lrz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-291633813-1167476863=:26556"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-291633813-1167476863=:26556
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 30 2006 01:00, Bodo Eggert wrote:
>Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>> On Dec 29 2006 07:57, Daniel Marjamäki wrote:
>
>>> It was my goal to improve the readability. I failed.
>>>
>>> I personally prefer to use standard functions instead of writing code.
>>> In my opinion using standard functions means less code that is easier to
>>> read.
>> 
>> Hm in that case, what about having something like
>> 
>> void *memset_int(void *a, int x, int n) {
>>     asm("mov %0, %%esi;
>>          mov %1, %%eax;
>>          mov %2, %%ecx;
>>          repz movsd;",
>>        a,x,n);
>> }
>
>This would copy the to-be-initialized buffer somewhere, if it compiles.

Yeah I don't do assembler soo often that I would know everything from heart.
All your comments are valid of course. I just wanted to point out the idea.
(However, if it's not repz, then it's repnz! :-)

	-`J'
-- 
--1283855629-291633813-1167476863=:26556--
