Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWJCOGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWJCOGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWJCOGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:06:10 -0400
Received: from sandeen.net ([209.173.210.139]:15673 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S1750879AbWJCOGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:06:07 -0400
Message-ID: <45226E4D.8020302@sandeen.net>
Date: Tue, 03 Oct 2006 09:06:05 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
References: <451C33B2.5000007@goop.org> <20060928142313.8848cec9.akpm@osdl.org> <4521F5DE.7070302@sandeen.net> <20061003054242.GK3278@stusta.de>
In-Reply-To: <20061003054242.GK3278@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Oct 03, 2006 at 12:32:14AM -0500, Eric Sandeen wrote:
>> Andrew Morton wrote:

>>>> BUG: unable to handle kernel paging request at virtual address 756e6547
>>> 756e6547 -> uneG.   Matches "GenuineIntel".
>>>
>>> That'll get written into a temporary page by the /proc/cpuinfo handler, so
>>> it might just be a use-uninitialised.
>> But strangely enough, it's the second report we've seen with this exact 
>> backtrace, and the same "Genu" ascii string where the i_default_acl should 
>> be.
>>
>> Both boxes had been through a suspend-to-ram recently, just in case that 
>> might matter.
>>
>> Seems like something more than random chance...
> 
> Can you give a pointer to the other report?

Sure, https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=207658

-Eric
