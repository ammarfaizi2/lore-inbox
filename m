Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292238AbSCDI3r>; Mon, 4 Mar 2002 03:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292239AbSCDI3f>; Mon, 4 Mar 2002 03:29:35 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:63411 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S292238AbSCDI3U>; Mon, 4 Mar 2002 03:29:20 -0500
User-Agent: Microsoft-Entourage/10.0.0.1309
Date: Mon, 04 Mar 2002 09:29:26 +0100
Subject: Re: [PATCH] spinlock not locked when unlocking in atm_dev_register
From: Frode Isaksen <fisaksen@bewan.com>
To: Robert Love <rml@tech9.net>
Cc: <mitch@sfgoth.com>, <linux-kernel@vger.kernel.org>
Message-ID: <B8A8EEF6.E8B%fisaksen@bewan.com>
In-Reply-To: <1015020950.11295.25.camel@phantasy>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-03-01 at 12:46, Frode Isaksen wrote:
>> If you compile the kernel with SMP and spinlock debugging, BUG() will be
>> called when registering your atm driver, since the "atm_dev_lock" spinlock is
>> not locked when unlocking it.
> 
> I don't have any knowledge of the source in question, but wouldn't a
> possibility (perhaps even more likely) be that you should _add_ the
> spin_lock instead of remove the spin_unlocks ?
The atm_dev_register function is calling functions that are using the same
spinlock, so you cannot just lock the spinlock when entering the function..

Hilsen,
Frode

