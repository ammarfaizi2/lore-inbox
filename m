Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317390AbSGTGp4>; Sat, 20 Jul 2002 02:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSGTGp4>; Sat, 20 Jul 2002 02:45:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21135 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317390AbSGTGp4>;
	Sat, 20 Jul 2002 02:45:56 -0400
Date: Sun, 21 Jul 2002 08:47:58 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: anton wilson <anton.wilson@camotion.com>
Cc: J Sloan <jjs@lexus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 O(1) scheduler
In-Reply-To: <200207192018.QAA19141@test-area.com>
Message-ID: <Pine.LNX.4.44.0207210841310.5403-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, anton wilson wrote:

> I'm actually worried not about just the O(1) scheduler but if these
> patches will be incorporating the O(1) bug fixes such as the serious one
> in balance_load where curr->next was used instead of current->prev.

It's a harmless bug, somewhat reducing the amount of balancing we can do
on SMP, but the balancer was still pretty much intact (we'd have noticed
it earlier if it wasnt). The bug was found by Scott Rhine and myself not
because the scheduler behaved badly, but via code review, because the
comments did not match the code :-)

	Ingo

