Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWH3FzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWH3FzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 01:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWH3FzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 01:55:00 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:3036 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751072AbWH3Fy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 01:54:59 -0400
Date: Wed, 30 Aug 2006 07:54:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Drop cache has no effect?
In-Reply-To: <20060829183902.be1356b6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0608300751330.9263@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
 <20060829110048.20e23e75.akpm@osdl.org> <87k64rxc6g.fsf@duaron.myhome.or.jp>
 <20060829183902.be1356b6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> That's dirty area, vfat has one read-only bit only. Yes, I also think
>> this is strange behaviour. But, I worry app is depending on the
>> current behaviour, because this is pretty old behaviour.
>> 
>> Umm.., do someone have any strong reason? I'll make patch at this
>> weekend, and please test it in -mm tree for a bit long time...?
>
>It is pretty weird that permission bits on vfat can magically change in
>response to memory pressure.

Well, the same happened for procfs in the past (when one was able to chmod it,
in current kernels it is forbidden.)

>But no, I'm not really advocating any changes in this area - I don't recall
>any complaints (surprised) and the chances are that if we changed it
>(ie: not permit the inode to accept changes which cannot be stored on disk)
>then someone's app would break.
>
>otoh, it is pretty bad behaviour...

It seems the best thing ATM, no?


Jan Engelhardt
-- 
