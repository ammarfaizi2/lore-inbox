Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUBWC2g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUBWC2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:28:36 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:57862
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261772AbUBWC2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:28:35 -0500
Message-ID: <40396551.9030002@matchmail.com>
Date: Sun, 22 Feb 2004 18:28:33 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <200402220903.08299.edt@aei.ca>
In-Reply-To: <200402220903.08299.edt@aei.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:

> On February 21, 2004 10:28 pm, Linus Torvalds wrote:
> 
>>On Sat, 21 Feb 2004, Chris Wedgwood wrote:
>>
>>
>>>Maybe gradual page-cache pressure could shirnk the slab?
>>
>>
>>What happened to the experiment of having slab pages on the (in)active
>>lists and letting them be free'd that way? Didn't somebody already do 
>>that? Ed Tomlinson and Craig Kulesa?
> 
> 
> You have a good memory.  
> 
> We dropped this experiment since there was a lot of latency between the time a 
> slab page became freeable and when it was actually freed.  The current 
> call back scheme was designed to balance slab preasure and vmscaning.

Does it really matter if there is a lot of latency?  How does this 
affect real-world results?  IOW, if it's not at the end of the LRU, then 
there's probably something better to free instead...

