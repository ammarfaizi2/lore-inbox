Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWH3QbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWH3QbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWH3QbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:31:16 -0400
Received: from mail.parknet.jp ([210.171.160.80]:46852 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751131AbWH3QbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:31:14 -0400
X-AuthUser: hirofumi@parknet.jp
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Drop cache has no effect?
References: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
	<20060829110048.20e23e75.akpm@osdl.org>
	<87k64rxc6g.fsf@duaron.myhome.or.jp>
	<20060829183902.be1356b6.akpm@osdl.org>
	<Pine.LNX.4.61.0608300751330.9263@yvahk01.tjqt.qr>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 31 Aug 2006 01:31:04 +0900
In-Reply-To: <Pine.LNX.4.61.0608300751330.9263@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Wed, 30 Aug 2006 07:54:04 +0200 (MEST)")
Message-ID: <87ac5mtcc7.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> 
>>> That's dirty area, vfat has one read-only bit only. Yes, I also think
>>> this is strange behaviour. But, I worry app is depending on the
>>> current behaviour, because this is pretty old behaviour.
>>> 
>>> Umm.., do someone have any strong reason? I'll make patch at this
>>> weekend, and please test it in -mm tree for a bit long time...?
>>
>>It is pretty weird that permission bits on vfat can magically change in
>>response to memory pressure.
>
> Well, the same happened for procfs in the past (when one was able to chmod it,
> in current kernels it is forbidden.)

IIRC, at least 2.4 doesn't allow it, it's rather new.

> It seems the best thing ATM, no?

I also think it's good. But it wouldn't be good reason for breaking app...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
