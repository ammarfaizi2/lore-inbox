Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUHZRw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUHZRw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269083AbUHZQfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:35:22 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:48834 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S269182AbUHZQcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:32:36 -0400
Message-ID: <412E10A2.1020801@pobox.com>
Date: Thu, 26 Aug 2004 12:32:34 -0400
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
In-Reply-To: <412D9FE6.9050307@namesys.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Andrew, we need to compete with WinFS and Dominic Giampaolo's filesystem 
> for Apple, and that means we need to put search engine and database 
> functionality into the filesystem.  It takes 11 years of serious 

Hans,

I'm very curious about your ideas on how to put search engine and 
database functionality into the filesystem. Although I've let the Befs 
filesystem driver largely stagnate over the past two years, from time to 
time I think about the problem of exporting to userspace the attribute 
indexes that BeFS keeps on disk.

In the original BeOS, they solved the problem by having the filesystem 
driver itself take a text query string and parse it, returning a list of 
inodes that match. The whole business of parsing a query string in the 
kernel (let alone in the filesystem driver) has always seemed ugly to 
me. However, the best alternative I've come up with is to simply export 
the index data as a special file (perhaps in sysfs?) and have userspace 
responsible for searching the index. That would probably work, but it 
wouldn't help other filesystems that implement even a different index 
format, much less a different form of extra searchability.

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman
