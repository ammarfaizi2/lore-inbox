Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTDSXGF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 19:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTDSXGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 19:06:05 -0400
Received: from mail1.ewetel.de ([212.6.122.14]:42378 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263493AbTDSXGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 19:06:04 -0400
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.5] report unknown NMI reasons only once
In-Reply-To: <20030419230019$7cdc@gated-at.bofh.it>
References: <20030419183013$0e6c@gated-at.bofh.it> <20030419230019$7cdc@gated-at.bofh.it>
Date: Sun, 20 Apr 2003 01:17:49 +0200
Message-Id: <E1971af-0002vN-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003 01:00:19 +0200, you wrote in linux.kernel:

>> Those NMIs happen only rarely when the machine is lightly loaded, but
>> under load, I get several of them per second. This quickly makes
>> /var/log/messages grow.
> 
> I guess they are overheat traps then

At 41 degrees C reported CPU temperature, I don't think so. Even if this
is off by, say, 10 degrees, it's still not a problem. AMD allows 90 degrees
for my CPU type (Athlon XP 1700+, Thoroughbred core).

Maybe I should add that "under load" in this case means running OpenGL
games using DRI on a Voodoo4 card.

>> I don't think reporting any of those NMIs more than once provides
>> valuable information, so I've cooked up a patch which only reports each
>> unknown NMI reason once.
> 
> Its sitting there saying "Something is wrong" "Something is still
> wrong".

Beats me as to what could be wrong. It's not a memory problem and the
CPU does not overheat.

I'll go patch the kernel for my personal use then, but I'm not the only
one seeing those messages without any system problems.

-- 
Ciao,
Pascal
