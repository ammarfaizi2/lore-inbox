Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753087AbWKFQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbWKFQHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbWKFQHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:07:40 -0500
Received: from mail.tmr.com ([64.65.253.246]:60128 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1753087AbWKFQHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:07:39 -0500
Message-ID: <454F5DCA.4070005@tmr.com>
Date: Mon, 06 Nov 2006 11:07:38 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Daniel J Blueman <daniel.blueman@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, nfsv4@linux-nfs.org
Subject: Re: Poor NFSv4 first impressions
References: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
In-Reply-To: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel J Blueman wrote:
> Jeff Garzik wrote:
>> Being a big user of NFS at home, and a big fan of NFSv4, it was high
>> time that I converted my home network from NFSv3 to NFSv4.
>>
>> Unfortunately applications started breaking left and right.  vim
>> noticeably malfunctioned, trying repeatedly to create a swapfile (sorta
>> like a lockfile).  Mozilla Thunderbird would crash reproducibly whenever
>> it tried anything remotely major with a mailbox, such as compressing
>> folders (removing deleted messages).
> [snip]
> 
> This has all the symptoms to an open EACCES NFSv4 bug in 2.6.18/19.
> This is fixed in:
> 
> http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.19-rc3-2/linux-2.6.19-rc3-CITI_NFS4_ALL-2.diff 
> 
> (see http://www.citi.umich.edu/projects/nfsv4/linux/).
> 
> With this patch, I can run just great with NFSv4 home dir (etc)
> mounts; without, I get the symptom of many 0-byte temporary/lock files
> being created and often the inability to create files (!). Be sure to
> allow callback delegation connections in through your firewall for the
> extra performance ;-) .
> 
> Maybe it's too late for these fixes 2.6.19, but they should certainly
> make 2.6.19.1 IMHO.

If NFSv4 really works that poorly without the patches, perhaps they 
should go in 2.6.19 at the start. I'm surprised others aren't having 
this problem, I thought there was more test use.


-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
