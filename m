Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268585AbRGYQhE>; Wed, 25 Jul 2001 12:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268586AbRGYQg4>; Wed, 25 Jul 2001 12:36:56 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:51218 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268584AbRGYQgs>;
	Wed, 25 Jul 2001 12:36:48 -0400
Message-Id: <200107242224.CAA00437@mops.inr.ac.ru>
Subject: Re: Minor net/core/sock.c security issue?
To: davem@redhat.COM (David S. Miller)
Date: Wed, 25 Jul 2001 02:24:55 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15196.45004.237634.928656@pizda.ninka.net> from "David S. Miller" at Jul 24, 1 03:45:01 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> 1) Signedness, what you have discovered.
> 
> 2) Arg evaluation.

Damn, I always assumed that min/max are macros and took into account #2,
which was painful sometimes. :-)

The fact that it is defined in sock.h (and the definition is truly
crazy, add #4: it is funny what happens on 64bit archs, when one of args
happens to be long) 


> 1) have standard inline functions with names that suggest the
>    signedness, much like Rusty's netfilter macros.

min/max are macros. I do not know how to make a valid inline
for it: cast to long has problems with unsigned longs, cast to unsigned long
have the same problems with signedness.


Alexey
