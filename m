Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277751AbRJLQpE>; Fri, 12 Oct 2001 12:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277758AbRJLQoy>; Fri, 12 Oct 2001 12:44:54 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:32009 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277751AbRJLQoi>;
	Fri, 12 Oct 2001 12:44:38 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110121644.UAA12030@ms2.inr.ac.ru>
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
To: sim@netnation.com (Simon Kirby)
Date: Fri, 12 Oct 2001 20:44:58 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011011125538.C10868@netnation.com> from "Simon Kirby" at Oct 11, 1 12:55:38 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Is it possible to fix this?  Was the 2.2 hash table just that much
> smaller?

2.2 did not use hash tables, holding special single list for /proc.

If I understand correctly it was removed because added more data/work
and new point of synchronization for main path being useful only for /proc.
The approach would be justified, if you had 100000 sockets. In this
case both approaches are equally slow. :-) But for 1000 sockets hash
table of 100000 entries is sort of overscaled.


> Is it possible to fix this?

To fix --- no. To make differently --- yes.

Well, actually, if you are interested drop me a not I can pack for you some
my old work on this. It is fully functional, but api is still dirty.
It requires some patching kernel, unfortunately.

Alexey
