Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262849AbSJAVPA>; Tue, 1 Oct 2002 17:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262850AbSJAVO7>; Tue, 1 Oct 2002 17:14:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25579 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262849AbSJAVOy>;
	Tue, 1 Oct 2002 17:14:54 -0400
Date: Tue, 1 Oct 2002 23:30:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <3D9A0E46.3070608@pobox.com>
Message-ID: <Pine.LNX.4.44.0210012328020.25070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Jeff Garzik wrote:

> At the risk of being on-topic <g>, would it be reasonable to request a
> 2.4 version of this patch, that can be used in driver-compat code and
> vendor kernels?  i.e. something that makes the workqueue API work in
> 2.4, no more, no less.

i've concentrated all the code into kernel/workqueue.c, and all the
interfaces into include/linux/workqueue.h - so you can simply copy those
into the 2.4 tree and it should just work. There should be no namespace
collision either. A O(1) scheduler tree is needed, due to
set_cpus_allowed(), but there is no other dependency i think.

	Ingo

