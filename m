Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUKUKWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUKUKWA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKUKV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:21:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20352 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261496AbUKUKVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:21:50 -0500
Date: Sun, 21 Nov 2004 11:21:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: wait_event_interruptible() seems non-atomic
In-Reply-To: <41A0673D.8030504@colorfullife.com>
Message-ID: <Pine.LNX.4.53.0411211120030.4205@yvahk01.tjqt.qr>
References: <419F6DEB.6030606@colorfullife.com> <Pine.LNX.4.53.0411201718040.925@yvahk01.tjqt.qr>
 <419F8D7A.1020305@colorfullife.com> <Pine.LNX.4.53.0411211039240.242@yvahk01.tjqt.qr>
 <41A0673D.8030504@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Well, it's just one line so I would not care, and I'm also open for
>>suggestions. Does down_interruptible() cost so much more in CPU cycles than
>>down()?
>
>It's more about code complexity than performance. down_interruptible()
>means that you must handle failures - double check that you free all
>temporary allocations, decrease all reference counts (make the reference
>counts atomic_t), etc.

All considered. rpldev.c only has 4 occurrences of down_interruptible, all
which are near the start of the function body. There's nothing to deallocate at
the time down_interruptible() is due ;-)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
