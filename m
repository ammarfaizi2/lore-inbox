Return-Path: <linux-kernel-owner+w=401wt.eu-S965053AbWL2KOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWL2KOI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWL2KOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:14:07 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:32857 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965053AbWL2KOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:14:06 -0500
Date: Fri, 29 Dec 2006 11:13:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@gmail.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Want comments regarding patch
In-Reply-To: <80ec54e90612282257m4175347x226cd1b045059336@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612291106480.23545@yvahk01.tjqt.qr>
References: <80ec54e90612281041q3b2c2bcemb0308c1e89a29ac@mail.gmail.com> 
 <1167331995.3281.4374.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0612290043050.23545@yvahk01.tjqt.qr>
 <80ec54e90612282257m4175347x226cd1b045059336@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-482809503-1167387187=:23545"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-482809503-1167387187=:23545
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 29 2006 07:57, Daniel Marjamäki wrote:
>
> It was my goal to improve the readability. I failed.
>
> I personally prefer to use standard functions instead of writing code.
> In my opinion using standard functions means less code that is easier to read.

Hm in that case, what about having something like

void *memset_int(void *a, int x, int n) {
    asm("mov %0, %%esi;
         mov %1, %%eax;
         mov %2, %%ecx;
         repz movsd;",
       a,x,n);
}

in include/asm-i386/ and asm-x86_64/? (For x86_64, also a memset_long 
that uses rsi/rax/rcx/movsq)


	-`J'
-- 
--1283855629-482809503-1167387187=:23545--
