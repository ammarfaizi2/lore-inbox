Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWCZSqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWCZSqk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCZSqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:46:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34699 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751096AbWCZSqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:46:39 -0500
Date: Sun, 26 Mar 2006 20:46:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stas Sergeev <stsp@aknet.ru>
cc: 7eggert@gmx.de, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
In-Reply-To: <44266472.5080309@aknet.ru>
Message-ID: <Pine.LNX.4.61.0603262042400.28657@yvahk01.tjqt.qr>
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it>
 <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it>
 <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The problem is that the snd-pcsp doesn't replace pcspkr.
>>>
>> If that's the problem, create a minimal input driver that will signal the
>> snd-pcsp to beep, and change the original pcspkr to include "(Non-ALSA)".
>>
> Yes, making snd-pcsp to produce the console beeps and
> making it mutually exclusive with pcspkr is possible.
> But I think it is undesireable. People that don't like
> the console beeps (myself included) simply do not load

I like the current approach, that is, load pcspkr to get a beep, load 
pcspkr+snd-pcsp to get the full blow.

On some servers, I need a mixture of when to allow a beep and when not. In 
these, I patched the oops and panic functions to make a sound, which 
implies that pcspkr.ko must be loaded. In turn, I modified vt.c to have the 
default bell time = 0 to shut /bin/*sh up. Works good.


Jan Engelhardt
-- 
