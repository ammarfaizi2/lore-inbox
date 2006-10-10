Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWJJUux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWJJUux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWJJUux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:50:53 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:2190 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1030342AbWJJUuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:50:52 -0400
Date: Tue, 10 Oct 2006 22:50:51 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Paul Wouters <paul@xelerance.com>
Cc: fedora-xen@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more random device badness in 2.6.18 :(
Message-ID: <20061010205051.GB14865@boogie.lpds.sztaki.hu>
References: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 08:08:32PM +0200, Paul Wouters wrote:

> Since hardware random is not transparently added to /dev/random's entropy,
> applications such as Openswan need to test for the availability of the
> seperate device file (not a good design imho). So Openswan will use
> /dev/hw_random if available.

Why should Openswan touch /dev/hw_random directly?

> Every call to /dev/hw_random gives that one (not very random!) line of output,
> and then nothing more ever. A call to /dev/random still works:

$ apt-cache show rng-tools
 [...]
 The rngd daemon acts as a bridge between a Hardware TRNG (true random number
 generator) such as the ones in some Intel/AMD/VIA chipsets, and the kernel's
 PRNG (pseudo-random number generator).
 .
 It tests the data received from the TRNG using the FIPS 140-2 (2002-10-10)
 tests to verify that it is indeed random, and feeds the random data to the
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 kernel entropy pool.
 [...]

There is a good reason why /dev/hw_random is different from /dev/random...

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
