Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbUBCBBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265587AbUBCBBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:01:55 -0500
Received: from s4.uklinux.net ([80.84.72.14]:51352 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S265400AbUBCBBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:01:52 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040201151111.4a6b64c3.akpm@osdl.org>
	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>
	<401DDCD7.3010902@cyberone.com.au> <401E1131.6030608@cyberone.com.au>
	<87d68xcoqi.fsf@codematters.co.uk> <401EDEF2.6090802@cyberone.com.au>
	<20040202154959.283cf60b.akpm@osdl.org>
From: Philip Martin <philip@codematters.co.uk>
Date: Tue, 03 Feb 2004 01:01:20 +0000
In-Reply-To: <20040202154959.283cf60b.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 2 Feb 2004 15:49:59 -0800")
Message-ID: <87isipvuvz.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Nick Piggin <piggin@cyberone.com.au> wrote:
>>
>> Andrew, any other ideas?
>
> There seems to be a lot more writeout happening.

As far as I can see (and hear!) that's true.

> You could try setting /proc/sys/vm/dirty_ratio to 60 and
> /proc/sys/vm/dirty_background_ratio to 40.

Not much different:

2.6.1 (without elevator=deadline)

dirty_ratio:60 dirty_background_ratio:40

245.58user 121.82system 3:31.79elapsed 173%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3771340minor)pagefaults 0swaps

dirty_ratio:40 dirty_background_ratio:10  (the defaults)

245.75user 121.33system 3:35.13elapsed 170%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3770826minor)pagefaults 0swaps


-- 
Philip Martin
