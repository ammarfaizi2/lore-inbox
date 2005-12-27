Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVL0Cdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVL0Cdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 21:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVL0Cdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 21:33:44 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62613 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750785AbVL0Cdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 21:33:44 -0500
Date: Mon, 26 Dec 2005 20:33:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
In-reply-to: <5nt1F-5aZ-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43B0A804.5010605@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5mRSA-6ss-15@gated-at.bofh.it> <5n1S5-9P-21@gated-at.bofh.it>
 <5n1S5-9P-19@gated-at.bofh.it> <5nt1F-5aZ-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> On Friday 23 December 2005 20:33, Daniel Jacobowitz wrote:
> 
>>Applications have to run on existing platforms and work with existing
>>software, as I'm sure you know.  If someone anywhere in the food chain
>>isn't ready for NPTL, a project can easily be stuck with LT for another
>>few years.
> 
> 
> Not sure about NPTL support in non-Linux-based operating systems (Solaris, 
> BSD, etc), but I'd be surprised if they supported LinuxThreads. Thus, 
> shouldn't NPTL really result in a *more* portable application?

NPTL vs. LinuxThreads is a purely Linux-specific (well, glibc-specific, 
perhaps) issue, it is merely an implementation detail of the POSIX 
pthreads functions which are present on other UNIX variants. A portable 
application should not care which (if either) is being used.

I'm presuming that the fact that setuid calls with LinuxThreads do not 
change the user ID on all threads is a violation of the POSIX pthreads 
specification.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

