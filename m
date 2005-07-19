Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVGSOy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVGSOy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVGSOy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:54:59 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:56069 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261396AbVGSOy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:54:58 -0400
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] FAT robustness
References: <42D9FDAC.3010109@sm.sony.co.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 19 Jul 2005 23:54:52 +0900
In-Reply-To: <42D9FDAC.3010109@sm.sony.co.jp> (Hiroyuki Machida's message of "Sun, 17 Jul 2005 15:41:48 +0900")
Message-ID: <87fyuaq20z.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki Machida <machida@sm.sony.co.jp> writes:

> We currently plan to add following features to address FAT corruption.
>
>     - Utilize standard 2.6 features as much as possible
> 	- Implement as options of fat, vfat and uvfat

What is the uvfat? typo (xvfat)?  Why is this an option (does it have
the big demerit)?

> 	- Utilize noop elevator to cancel unexpected operation reordering

Why don't you use the barrier?

>     - Coordinate order of operations so that update data first, meta
> 	 data later with transaction control

Is this meaning the SoftUpdates? What does this guarantee? How does
this handle the rename(), and cyclic dependency of updates?

>     - With O_SYNC, close() make flush all related data and
> 	 meta-data, then wait completion of I/O

What is this meaning? Why does O_SYNC only flush at close()?

Almost things in your email is needing the detail.
I'm thinking the SoftUpdates is best solution for now. Could you tell
the detail of your solution?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
