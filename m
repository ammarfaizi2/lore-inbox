Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUD2Au1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUD2Au1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUD2Au1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:50:27 -0400
Received: from mail.fastclick.com ([205.180.85.17]:46828 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S262311AbUD2AuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:50:14 -0400
Message-ID: <40905127.3000001@fastclick.com>
Date: Wed, 28 Apr 2004 17:49:43 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com>
In-Reply-To: <409047E6.5000505@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Andrew Morton wrote:
> 
>> Swapout is good.  It frees up unused memory.  I run my desktop 
>> machines at
>> swappiness=100.
> 
> 
> 
> The definition of "unused" is quite subjective and app-dependent...
> 
> I've see reports with increasing frequency about the swappiness of the 
> 2.6.x kernels, from people who were already annoyed at the swappiness of 
> 2.4.x kernels :)
> 
> Favorite pathological (and quite common) examples are the various 4am 
> cron jobs that scan your entire filesystem.  Running that process 
> overnight on a quiet machines practically guarantees a huge burst of 
> disk activity, with unwanted results:
> 1) Inode and page caches are blown away
> 2) A lot of your desktop apps are swapped out
> 
> Additionally, a (IMO valid) maxim of sysadmins has been "a properly 
> configured server doesn't swap".  There should be no reason why this 
> maxim becomes invalid over time.  When Linux starts to swap out apps the 
> sysadmin knows will be useful in an hour, or six hours, or a day just 
> because it needs a bit more file cache, I get worried.
> 
> There IMO should be some way to balance the amount of anon-vma's such 
> that the sysadmin can say "stop taking 70% of my box's memory for 
> disposable cache, use it instead for apps you would otherwise swap out, 
> you memory-hungry kernel you."
> 
>     Jeff

Or how about "Use ALL the cache you want Mr. Kernel.  But when I want 
more physical memory pages, just reap cache pages and only swap out when 
the cache is down to a certain size(configurable, say 100megs or 
something)."


