Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbTIDSj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbTIDSh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:37:58 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:63940 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265444AbTIDShL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:37:11 -0400
Message-ID: <3F578656.60005@namesys.com>
Date: Thu, 04 Sep 2003 22:37:10 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com>
In-Reply-To: <20030904181540.GC13676@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

>On Thu, Sep 04, 2003 at 08:25:18PM +0400, Hans Reiser wrote:
>  
>
>>In data=journal and data=ordered modes ext3 also guarantees that the 
>>metadata will be committed atomically with the data they point to.  However 
>>ext3 does not provide user data atomicity guarantees beyond the scope of a 
>>single filesystem disk block (usually 4 kilobytes).  If a single write() 
>>spans two disk blocks it is possible that a crash partway through the write 
>>will result in only one of those blocks appearing in the file after 
>>recovery.
>>    
>>
>
>And how does reiser4 do this without changing the userspace apps?
>
We don't.  We just make the hovercraft, we don't force you to go over 
the water.....

>
>Most files are written with several write() calls, so even if each call is
>atomic, your entire file will not be there.
>
>Also, ext3 could claim the same atomicity if it only updated meta-data on
>write() call boundaries, instead of block boundaries.
>
>
>  
>


-- 
Hans


