Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbUAVHiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 02:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAVHiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 02:38:12 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:47584 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S265337AbUAVHiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 02:38:09 -0500
Message-ID: <400F7DCC.4080807@hanaden.com>
Date: Thu, 22 Jan 2004 01:37:48 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031204 Thunderbird/0.4RC1
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Stale Filehandles was: [2.6] nfs_rename: target $file busy, d_count=2
References: <20040122071739.1376f824.j.m.boler@sms.ed.ac.uk>
In-Reply-To: <20040122071739.1376f824.j.m.boler@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having them consistently with 2.6.0 and 2.6.1 clients 
against 2.6.0 and/or 2.6.1 servers.

2.6.1 and 2.6.0 against a 2.4.x server has no problems.

Jonathan Boler wrote:
> On Fri, Jan 16, 2004 at 10:40:31AM -0800, Mike Fedyk wrote:
> 
>>>I only had a few nfs clients doing light load, (kde home directories, and
>>>such) and was able to reproduce stale nfs file handles just by running "find
>>>
>>>>/dev/null" on the nfs share.
>>>
>>>Have you tried the -mm tree recently? 2.6.1-mm4 even has some new nfsd
>>>patches in there (maybe you should wait until -mm5 though, there are a few
>>
>>Stale filehandles is the main problem right now, and I don't see how
>>nfs_raname would be related (just that it was there while I was having
>>trouble with the stale file handles...)
>>
>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/nfsd-01-stale-filehandles-fixes.patch
>>
>>This one looks particularly interesting...
> 
> 
> I was getting alot of nfsv3 stale file handles with 2.6.1-mm1 so I dropped back to 2.6.1.
> 
> mm5 seems to have fixed everything.
> 
> Jonathan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
