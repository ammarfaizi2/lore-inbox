Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318417AbSGYJ0v>; Thu, 25 Jul 2002 05:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318418AbSGYJ0v>; Thu, 25 Jul 2002 05:26:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7892 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318417AbSGYJ0T>;
	Thu, 25 Jul 2002 05:26:19 -0400
Date: Thu, 25 Jul 2002 11:28:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
In-Reply-To: <20020724.225921.108418454.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207251126120.20754-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, David S. Miller wrote:

> I really think it is unwise to even imply that this kind of cli/sti
> fixup can be done in some mindless manner, it really can't :-)

i think the networking code is a special case - nothing else relies on the
interaction of timers and IRQ contexts in such a deep way. (which it does
for performance reasons.) I'd say 99% of all cli()/sti() users are in the
'introduce a per-driver or per-subsystem lock' league Linus mentioned.

	Ingo

