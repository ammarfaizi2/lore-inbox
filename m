Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268886AbRG0Qot>; Fri, 27 Jul 2001 12:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268888AbRG0Qo3>; Fri, 27 Jul 2001 12:44:29 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:8712 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268886AbRG0QoZ>;
	Fri, 27 Jul 2001 12:44:25 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107271644.UAA18916@ms2.inr.ac.ru>
Subject: Re: Minor net/core/sock.c security issue?
To: davem@redhat.com (David S. Miller)
Date: Fri, 27 Jul 2001 20:44:19 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15201.15059.75725.225907@pizda.ninka.net> from "David S. Miller" at Jul 27, 1 02:56:35 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> For the time being I've just killed that bogus min define

It is not bogus. Bogus one is in sock.h.

Hundred times I discovered that min/max are not defined in some place,
but was lazy to search for header where they are defined. :-)


> I mean, grep for "define [min|max]" in just the networking
> sources right now, yuck!

grep better for min/max. Everywhere min/max are assumed to be shortcut
for (a<b?a:b).

And if you find a place, which relied on that silly inline in sock.h,
I will wonder at first and die of shame the next minute. :-)

Alexey
