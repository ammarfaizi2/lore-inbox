Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVL3HNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVL3HNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVL3HNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:13:52 -0500
Received: from [218.25.172.144] ([218.25.172.144]:28942 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751201AbVL3HNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:13:51 -0500
Message-ID: <43B4DE26.9000306@fc-cn.com>
Date: Fri, 30 Dec 2005 15:13:42 +0800
From: Qi Yong <qiyong@fc-cn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Anderson <ryan@michonline.com>
CC: Alejandro Bonilla <alejandro.bonilla@hp.com>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: git fetching
References: <43B48516.2030701@hp.com> <20051230010151.GC12822@redhat.com> <43B48A8C.8000708@michonline.com>
In-Reply-To: <43B48A8C.8000708@michonline.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Anderson wrote:

>Dave Jones wrote:
>  
>
>>On Thu, Dec 29, 2005 at 06:53:42PM -0600, Alejandro Bonilla wrote:
>> > Why is it that when I git fetch, this particular part takes a long time?
>> > 
>> > pack/pack-2dae6bb81ac4383926b1d6a646e3f73b130ba124.pack
>> > 
>> > Normally, they go pretty fast, but when a new rc or final releases comes 
>> > up, it takes a lot.
>>
>>That file is ~100MB. That'll take a while to download compared to the rest,
>>even on the fastest net connection :)
>>    
>>
>
>If you're carrying around a mostly current tree, you should probably not
>use "rsync" (which is probably why you're seeing that pack line)
>
>Run this:
>	sed -i.old -e 's/rsync/git/' .git/remotes/origin
>and your pulls should go significantly faster.
>  
>

I don't have the directory .git/remotes/. Here's .git/FETCH_HEAD however.

>(The file named "origin" might be in .git/branches/, also.)
>  
>

Yes, here's .git/branches/origin.

-- Coywolf

>You want the file to contain pretty much just this line:
>git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
>Also, out of curiosity, do:
>	du -sh .git/objects/ .git/objects/pack/
>
>You shouldn't see a .git/objects/pack/ much greater than 200 meg, in
>fact, on freshly cloned tree it would only be about 100 meg:
>
>http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/
>
>  
>

