Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136675AbREAR0k>; Tue, 1 May 2001 13:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136672AbREAR03>; Tue, 1 May 2001 13:26:29 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:64525 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S136670AbREAR0P>;
	Tue, 1 May 2001 13:26:15 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105011725.VAA00484@ms2.inr.ac.ru>
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 1 May 2001 21:25:43 +0400 (MSK DST)
Cc: davem@redhat.com, ralf@nyren.net, linux-kernel@vger.kernel.org
In-Reply-To: <20010501190942.B31373@athlon.random> from "Andrea Arcangeli" at May 1, 1 07:09:42 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> zero and we are running in such slow path, it is obvious the send_head
> _was_ NULL when we entered the critical section, so it's perfectly fine

It is not only not obvious, it is not true almost always.
On normally working tcp send_head is almost never NULL,
it is NULL only when application is so slow that is not able
to saturate pipe. If you do not believe my word, add printk checking this. 8)

Alexey
