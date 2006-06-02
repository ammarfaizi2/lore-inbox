Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWFBHnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWFBHnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWFBHnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:43:32 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:49056 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751278AbWFBHnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:43:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=t3/hjyK4xv4U3w4KWJRZUTT08+BCMD8ewE9LcMiaiM9Pe5eFo5IU9ba2nFwTAk+bAC5fNzGr+fupypJyvCHT8cnQuaiwDYoMgh0+Ia0+gc0Nou1E8JOVnrmN8B7OLvHKVcUg+G8nbdqKJHNrSHvINQKBvCdQwGy8IcbNYN/cPzs=  ;
Message-ID: <447FEC1B.80205@yahoo.com.au>
Date: Fri, 02 Jun 2006 17:43:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Abu M. Muttalib" <abum@aftek.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??
References: <BKEKJNIHLJDCFGDBOHGMEEJNCNAA.abum@aftek.com>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMEEJNCNAA.abum@aftek.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abu M. Muttalib wrote:
> Hi,
> 
> I repeat my question, the required no of pages are available, as shown in
> the dump produced by kernel, the request is not fulfilled. Its as follows:
> 
> DMA: 106*4kB 11*8kB 5*16kB 3*32kB 2*64kB 1*128kB 0*256kB 0*512kB 0*1024kB =
> 944kB
> 
> Why this is so??

Because some are kept in "emergency pools" for allocators that cannot
sleep trying to free up memory.

Teach the sound driver to use smaller buffers or just insert it at boot
and leave it inserted. Why are you removing it then reinserting it?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
