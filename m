Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbULJIA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbULJIA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 03:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbULJIA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 03:00:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25579 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261715AbULJIAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 03:00:23 -0500
Date: Fri, 10 Dec 2004 09:00:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
In-Reply-To: <20041210075429.GA30223@kroah.com>
Message-ID: <Pine.LNX.4.53.0412100859210.15980@yvahk01.tjqt.qr>
References: <20041210005055.GA17822@kroah.com> <Pine.LNX.4.53.0412100805440.8273@yvahk01.tjqt.qr>
 <20041210075429.GA30223@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have to admit that adding another filesystem that is very like procfs or
>> sysfs make some kind of redundancy.
>
>Why?  The main issue is the discussion usually goes like this:
>
>Me:  Hey, the /proc/driver/foo/foo_value really shouldn't be in proc.
>Developer:  Ok, but it has a lot of really good debug stuff in it.  Can
>I put it in sysfs?
>Me:  No, sysfs is for one-value-per-file whenever possible.  It needs to
>go somewhere else.
>Developer:  Well, if you don't have anywhere else to put it, why are you
>even bringing this up at all.  Go away and leave me alone.

So how about adding seqfiles (or multi-value-per-file things) to sysfs?

>As for "another filesystem", it's tiny due to using libfs, and it will
>compile away into nothing if not selected (so in the end, provides the
>ability to make the final kernel image smaller.)

Ah that's good news.



Jan Engelhardt
-- 
ENOSPC
