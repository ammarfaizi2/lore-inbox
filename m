Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUG1BVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUG1BVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUG1BVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:21:39 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:55161 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266748AbUG1BVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:21:38 -0400
Message-ID: <4106FF9F.5060609@yahoo.com.au>
Date: Wed, 28 Jul 2004 11:21:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Klaus Dittrich <kladit@t-online.de>
CC: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
References: <20040726150615.GA1119@xeon2.local.here> <20040726123702.222ae654.akpm@osdl.org> <4105633C.3080204@xeon2.local.here> <20040726133846.604cef91.akpm@osdl.org> <41057A16.60801@xeon2.local.here> <20040726221420.GA8789@ii.uib.no> <4106BE6C.1030701@xeon2.local.here> <4106C3B7.10603@xeon2.local.here>
In-Reply-To: <4106C3B7.10603@xeon2.local.here>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich wrote:
> Klaus Dittrich wrote:

>> I did a test with a value of 500. echo 500 > 
>> /proc/sys/vm/vfs_cache_pressure.
>>
>> The highest numbers a cat /proc/sys/fs/dentry-state then showed during
>> a du -s were
>> 780721  750505  45      0       0       0
>>
>> The system survied. No processes were killed.
>>
>> With vfs_cache_pressure=100 a cat /proc/sys/fs/dentry-state showed
>> numbers of about 1090000 before processes got killed.
>>
>> Hope that helps to narrow the region to look for what has changed.
>>
> PS. Two concurrent du -s however "kernel: Out of Memory: Killed process .."

Your vfs_cache_pressure probably wants to be higher than 500. Make it 10000.
