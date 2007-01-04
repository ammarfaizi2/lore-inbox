Return-Path: <linux-kernel-owner+w=401wt.eu-S932250AbXADD6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbXADD6C (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbXADD6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:58:01 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:41519 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932250AbXADD6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:58:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BQldCuGzOtql4LSOc++5i9SUKkcRwGUW2/NU74LCqt7VKnMFIl3cZkBihP/n5/8tSfIOcfZ2un+ODBq6kiavLzZ2Lh0dO64wgXWm1hbFjVaz7P5vC3Istoe+/kYBT07ISWQvjZL4Mg4EXaB1tnxSc3A/yWQcD1Vbd0ARrOI9GYg=  ;
X-YMail-OSG: dmYBDngVM1l8kYKqK1DnspjqGqdnhVHhyMJMp04bvX1hCkRFsIxvryHiELr4nD7t75d2cartfoWFo6je2_8QX8wYBX6LA7KLgSsbzJoiYJK5U0W9OtK6.BGONjT3U3fgs1mfqusz_Hj.q.E-
Message-ID: <459C7B24.8080008@yahoo.com.au>
Date: Thu, 04 Jan 2007 14:57:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Gelmini <gelma@gelma.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net>
In-Reply-To: <20061231135031.GC23445@gelma.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Gelmini wrote:
> On Sun, Dec 31, 2006 at 02:55:58PM +1100, Nick Piggin wrote:
> 
>>This bug was only introduced in 2.6.19, due to a change that caused pte
> 
> no, Linus said that with 2.6.19 it's easier to trigger this bug...

Yhat's when the bug was introduced -- 2.6.19. 2.6.18 does not have
this bug, so it cannot be years old.

>>So if your corruption is years old, then it must be something else.
>>Maybe it is hidden by a timing change, or BDB isn't using msync properly.
> 
> I can give you a complete image where just changing kernel (everything
> is same, of course) corruptions goes away.
> we spent a lot, I mean a *lot*, of time looking for our code mistake,
> and so on.
> I don't want to seem rude, but I am sure that Berkeley DB corruption we
> have seen (not just Klibido, but I also think about postgrey, and so on)
> depends on this bug.
> I repeat, if you have time/interest I can give you a complete machine
> to see the problem.

You're not being rude, but I just wanted to point out that this patch
(nor the dirty page accounting also in 2.6.19) doesn't fix anything
that was in 2.6.18, AFAIKS.

I wouldn't discount a kernel bug, but it will be hard to track down
unless you can find an earlier kernel that did not cause the corruptions
and/or provide source for a minimal test case to reproduce.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
