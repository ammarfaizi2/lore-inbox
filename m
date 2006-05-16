Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWEPPEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWEPPEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWEPPEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:04:31 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:46063 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S932066AbWEPPE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:04:29 -0400
Message-ID: <4469E9ED.4010700@nortel.com>
Date: Tue, 16 May 2006 09:04:13 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Day <imipak@yahoo.com>,
       linux-kernel@vger.kernel.org, Zvika Gutterman <zvi@safend.com>
Subject: Re: /dev/random on Linux
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com> <1147732867.26686.188.camel@localhost.localdomain> <20060516025003.GC18645@rhun.haifa.ibm.com> <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com> <20060516124637.GB6654@elf.ucw.cz>
In-Reply-To: <20060516124637.GB6654@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2006 15:04:16.0549 (UTC) FILETIME=[0019DD50:01C678FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>I was unsure about the purported forward-security-breakage claims  
>>because I don't know how to validate those, but I seem to recall  
>>(from personal knowledge and the paper) that the kernel does an SHA1  
>>hash of the contents of the pool and the current cycle-counter when  
>>reading, uses that as input for the next pool state and returns it  
>>as /dev/random output.  Since the exact cycle-counter value is never  
>>exposed outside the kernel and only a small window of the previous  
> 
> 
> Are you sure? For vsyscalls to work, rdtsc has to be available from
> userspace, no?

I suspect he means "the exact cycle counter value at the time of reading 
the contents of the pool" is never exposed outside the kernel.

"rdtsc" is of course available in userspace on x86.

Chris
