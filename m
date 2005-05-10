Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVEJJog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVEJJog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEJJof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:44:35 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:36957 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261586AbVEJJob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:44:31 -0400
Message-ID: <4280827A.9080108@yahoo.com.au>
Date: Tue, 10 May 2005 19:44:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "linuxkernel2.20.sandos@spamgourmet.com" 
	<majsetvger.100.sandos@spamgourmet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :( message 1
 of 20)
References: <42806B78.2020708@home.se> <42806EA0.2070501@yahoo.com.au> <42807FC6.10400@spamgourmet.com>
In-Reply-To: <42807FC6.10400@spamgourmet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxkernel2.20.sandos@spamgourmet.com wrote:
> Nick Piggin - nickpiggin@yahoo.com.au wrote:
> 
>> linuxkernel2.20.sandos@spamgourmet.com wrote:

>>> It would be nice with a "cleaner" solution though.
>>>
>>
>> What kernel are you using?
>> Are you doing a lot of block IO as well?
> 
> 
> I am using 2.6.11.8.
> 
> Yes, the server is a fileserver for both the internet (~10Mbit) and 
> internally (1Gbit e1000). Hardware is pretty old so is pretty heavily 
> loaded and with 256MB RAM.
> 

OK, well there are some patches in 2.6.12 that should make
things slightly better, and then some more patches in -mm
(not sure if they'll make it for 2.6.12) that should make
things slightly better again.

Basically they work towards reducing the memory allocation
"priority" for block IO requests, in relation to networking
and other atomic allocation requirements.

If you can't test the latest -mm, or 2.6.12-rc4, then wait
for 2.6.12 and 2.6.13 and check back on the problem.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

