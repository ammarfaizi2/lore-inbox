Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbUKUJkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbUKUJkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 04:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUKUJkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 04:40:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15851 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261941AbUKUJkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 04:40:17 -0500
Date: Sun, 21 Nov 2004 10:40:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: wait_event_interruptible() seems non-atomic
In-Reply-To: <419F8D7A.1020305@colorfullife.com>
Message-ID: <Pine.LNX.4.53.0411211039240.242@yvahk01.tjqt.qr>
References: <419F6DEB.6030606@colorfullife.com> <Pine.LNX.4.53.0411201718040.925@yvahk01.tjqt.qr>
 <419F8D7A.1020305@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>For example the use of down_interruptible() looks wrong to me, I'd use
>>>plain down().
>>
>>I'd like to be able to hit Ctrl+C (in the userspace application) whenever
>>possible. If that's not a reason, blame the book
>>http://www.xml.com/ldd/chapter/book/ch03.html#t8 ("the read method" a further
>>down below)
>
>You have already written the code, so I'd leave it as it is and I'll
>blame the book. They probably started from an older version of
>fs/pipe.c, which contained _interruptible calls. There are gone now,
>this allowed some cleanup.

Well, it's just one line so I would not care, and I'm also open for
suggestions. Does down_interruptible() cost so much more in CPU cycles than
down()?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
