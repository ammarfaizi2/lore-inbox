Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318878AbSICUE6>; Tue, 3 Sep 2002 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318895AbSICUE6>; Tue, 3 Sep 2002 16:04:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:23610 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318878AbSICUE6>; Tue, 3 Sep 2002 16:04:58 -0400
Date: Tue, 3 Sep 2002 16:09:30 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200209032009.g83K9Ug14933@devserv.devel.redhat.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question on spinlocks
In-Reply-To: <mailman.1030918200.24262.linux-kernel2news@redhat.com>
References: <Pine.LNX.4.44.0209011553140.3234-100000@hawkeye.luckynet.adm> <mailman.1030918200.24262.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > No; spin_lock_irqsave/spin_unlock_irqrestore and spin_lock/spin_unlock
>> > have to be used in matching pairs.
>[...] 
> OK, how do I drop an irqsave spinlock if I don't have flags?

It was a good thing you didn't have flags, because everything
that passes flags as arguments blows up on sparc immediately.

Most likely answer is "restructure your locking".

-- Pete
