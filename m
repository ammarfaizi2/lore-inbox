Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVKWBRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVKWBRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVKWBR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:17:29 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:20078 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030299AbVKWBR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:17:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cOEEO4sdEe3+V7U2C0ger0twMVqrHaBl91NKRt3+A8dNxavVBqsNTuwFSOSnP8/LDDAA095Pwh/Lu2VG/uY4RgFQmU1Cbvdr/ehMaJs18DcKpvZ7NdGscOJ611Mfo2wnnx7C4b5K+jHjpc6ujry97rUqDfj3L86uUrtixkxzSr0=  ;
Message-ID: <4383D1CC.4050407@yahoo.com.au>
Date: Wed, 23 Nov 2005 13:19:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Kasprzak <kas@fi.muni.cz>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
References: <20051122125959.GR16080@fi.muni.cz> <20051122163550.160e4395.akpm@osdl.org> <20051123010122.GA7573@fi.muni.cz>
In-Reply-To: <20051123010122.GA7573@fi.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
> Andrew Morton wrote:
> : Jan Kasprzak <kas@fi.muni.cz> wrote:
> : >
> : > I have noticed that on my system kswapd eats too much CPU time every two
> : > hours or so. This started when I upgraded this server to 2.6.14.2 (was 2.6.13.2
> : > before), and added another 4 GB of memory (to the total of 8GB).
> : 
> : Next time it happens, please gather some memory info (while it's happening):
> : 
> : 	cat /proc/meminfo
> 
[snip]

> 	Hope this helps,
> 

Can't see anything yet. Sysrq-M would be good. cat /proc/zoneinfo gets you
most of the way there though.

A couple of samples would be handy, especially from /proc/vmstat.

cat /proc/vmstat > vmstat.out ; sleep 10 ; cat /proc/vmstat >> vmstat.out

The same for /proc/zoneinfo would be a good idea as well.

Also - when you say "too much cpu time", what does this mean? Does
performance noticably drop compared with 2.6.13 performing the same cron
job? Because kswapd is supposed to unburden other processes from page
reclaim work, so if it is working *properly*, then the more CPU it uses
the better.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
