Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268802AbRG0J5a>; Fri, 27 Jul 2001 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268815AbRG0J5W>; Fri, 27 Jul 2001 05:57:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30086 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268802AbRG0J5F>;
	Fri, 27 Jul 2001 05:57:05 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15201.15059.75725.225907@pizda.ninka.net>
Date: Fri, 27 Jul 2001 02:56:35 -0700 (PDT)
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Minor net/core/sock.c security issue?
In-Reply-To: <200107242224.CAA00437@mops.inr.ac.ru>
In-Reply-To: <15196.45004.237634.928656@pizda.ninka.net>
	<200107242224.CAA00437@mops.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Alexey Kuznetsov writes:
 > > 1) have standard inline functions with names that suggest the
 > >    signedness, much like Rusty's netfilter macros.
 > 
 > min/max are macros. I do not know how to make a valid inline
 > for it: cast to long has problems with unsigned longs, cast to unsigned long
 > have the same problems with signedness.

For the time being I've just killed that bogus min define
from sock.c and also open-coded the min/max usage in the
rest of sock.c

This solves the original report, but later I'd like to do
something more satisfactory here.

I mean, grep for "define [min|max]" in just the networking
sources right now, yuck!

Later,
David S. Miller
davem@redhat.com
