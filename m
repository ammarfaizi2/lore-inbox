Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSKTW1w>; Wed, 20 Nov 2002 17:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSKTW1w>; Wed, 20 Nov 2002 17:27:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261950AbSKTW1v>;
	Wed, 20 Nov 2002 17:27:51 -0500
Date: Wed, 20 Nov 2002 14:33:29 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Richard Whittaker <rwhittak@gnat.nwtel.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Semaphore and Shared memory questions...
In-Reply-To: <5.1.1.6.0.20021120135311.0248d600@gnat.nwtel.ca>
Message-ID: <Pine.LNX.4.33L2.0211201432170.31148-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Richard Whittaker wrote:

| >Right first guess. Its mostly historical that it isnt 4 values.
|
| What's the order of the values?...
|
| I can take a wild stab that the first value is semmsl, or is it semmni,
| then the subsequent values?...
|
| Are there plans to split them out into distinct values, or is that a
| massive rewrite?...

I haven't seen a kernel version that you are working with,
but hopefully that won't matter.  This is from 2.4.19:

./ipc/sem.c:96:int sem_ctls[4] = {SEMMSL, SEMMNS, SEMOPM, SEMMNI};
./ipc/sem.c:97:#define sc_semmsl        (sem_ctls[0])
./ipc/sem.c:98:#define sc_semmns        (sem_ctls[1])
./ipc/sem.c:99:#define sc_semopm        (sem_ctls[2])
./ipc/sem.c:100:#define sc_semmni       (sem_ctls[3])

so that's the order.  If Alan replies, his matching reply can confirm
this.  :)

-- 
~Randy

