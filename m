Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289190AbSAGN1C>; Mon, 7 Jan 2002 08:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289197AbSAGN0r>; Mon, 7 Jan 2002 08:26:47 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:32897 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S289204AbSAGNX3>; Mon, 7 Jan 2002 08:23:29 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 7 Jan 2002 05:23:28 -0800
Message-Id: <200201071323.FAA04244@adam.yggdrasil.com>
To: davej@suse.de
Subject: Re: Patch?: linux-2.5.2-pre9/drivers/block/ll_rw_blk.c blk_rq_map_sg simplification
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> = Adam Richter (adam@yggdrasil.com)
>>  = Jens Axboe (axboe@suse.de)
>   = Dave Jones (davej@suse.de)
>>> 	The following patch removes gotos from blk_rq_map_sg, making
>>> it more readable and five lines shorter.  I think the compiler should
>>> generate the same code.  I have not tested this other than to
>>> verify that it compiles.
>> Well, I really think the original is much more readable than the changed
>> version :-)

>I agree. Upon seeing the patch, I was reminded of the monster
>enormous conditional at http://gcc.gnu.org/projects/beginner.html
>not quite _that_ bad, but getting there 8)

	The conditional is one level deep (it's just a list of
"and" conjunctions) and has a single conceptual meaning, "are
the segments joinable?"  For what it's worth, I really could not
understand the old version until I rewrote it without gotos.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
