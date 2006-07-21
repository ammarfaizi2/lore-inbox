Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWGUJoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWGUJoD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 05:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWGUJoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 05:44:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:43699 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750940AbWGUJoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 05:44:01 -0400
Message-ID: <44C093D2.1040703@namesys.com>
Date: Fri, 21 Jul 2006 02:44:02 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>
Subject: Re: reiser4 status (correction)
References: <44BFFCB1.4020009@namesys.com> <44C043B5.3070501@slaphack.com>
In-Reply-To: <44C043B5.3070501@slaphack.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> Hans Reiser wrote:
>
>> On a more positive note, Reiser4.1 is getting closer to release....
>
>
> Good news!  But it's been awhile since I've followed development, and
> the homepage seems out of date (as usual).  Where can I find a list of
> changes since v4?
>
> By "out of date", I mean things like this:
>
> "Reiser4.1 will modify the repacker to insert controlled "air holes",
> as it is well known that insertion efficiency is harmed by overly
> tight packing."

Sigh, no, the repacker will probably be after 4.1....

The list of tasks for zam looks something like:

fix bugs that arise

debug read optimization code (CPU reduction only, has no effect on IO),
1 week est.  (would be nice if it was less)

review compression code 1 day per week until it ships.

fix fsync performance (est. 1 week of time to make post-commit writes
asynchronous, maybe 3 weeks to create fixed-reserve for write twice
blocks, and make all fsync blocks write twice)

write repacker (12 weeks).

I am not sure that putting the repacker after fsync is the right choice....

The task list for vs looks like:

* fix bugs as they arise.

* fix whatever lkml complains about that either seems reasonable, or
that akpm agrees with.

* Help edward get the compression plugins out the door.

* Improve fsck's time performance.

* Fix any V3 bugs that Chris and Jeff don't fix for us.  Which reminds
me, I need to check on whether the 90% full bug got fixed....

