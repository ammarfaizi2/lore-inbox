Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTH2WZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 18:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTH2WZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 18:25:11 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:11206 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261910AbTH2WZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 18:25:06 -0400
Message-ID: <3F4FD2BE.1020505@wmich.edu>
Date: Fri, 29 Aug 2003 18:25:02 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] extents support for EXT3
References: <m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu> <m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu> <m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu> <m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu> <m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu> <20030829213940.GC3846@matchmail.com>
In-Reply-To: <20030829213940.GC3846@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Fri, Aug 29, 2003 at 03:55:14PM -0400, Ed Sweetman wrote:
> 
>>I would not recommend using the patch for system directories only 
>>because it leaves you with no way to rescue the system and does very 
>>little in the way of performance for those directories. Ext3 is 
>>backwards compatible with ext2, this patch seemingly breaks that. 
>>Because of that it doesn't seem to be ext3 anymore, rather a one way 
>>compatibility with ext3 with a purely large media bias.
> 
> 
> Do you get any slowdown with the extents on small files though?
> 
> The plan is to add extent reading code to the three other stable trees so
> that at the very least you could have read-only access to the extent based
> ext2/3.
> 
> Remember, if the implementation of journaling hadn't have been so extensive,
> we wouldn't have an ext3, but ext2 with journaling (and called ext2).
> 
> So what this will be is ext2 format with extents, and with (ext3) or without
> journaling (ext2).
> 
> And this is planned for 2.7, so if anything goes into 2.6, it'll be
> read-only support of extents.
> 

ext3 fs's could be read by ext2 drivers without having knowledge of what 
ext3 is.  Hence when ext3 was introduced, i could use present stable 
kernels to still fall back on in case things didn't go as planned 
(happened a lot in the beginning of ext3).  so ext3 fs's are compatible 
with ext2 without any knowledge of ext3.  This is more like the upgrade 
to ext2 that happened in 2.2 compared to 2.0 that made later ext2 fs's 
unreadable to the older 2.0 kernel produced ones.

you get no real slowdown as far as rough benchmarks are concerned, 
perhaps with a microbenchmark you would see one and also, doesn't it 
take up more space to save the extent info and such? Either way, all of 
it's real benefits occur on large files.

