Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSG3VwQ>; Tue, 30 Jul 2002 17:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSG3VwQ>; Tue, 30 Jul 2002 17:52:16 -0400
Received: from DNab4046bc.Stanford.EDU ([171.64.70.188]:7809 "EHLO
	pfaff.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S316821AbSG3VwO>; Tue, 30 Jul 2002 17:52:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
References: <Pine.LNX.4.33.0207301433480.2051-100000@penguin.transmeta.com> <Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 30 Jul 2002 14:55:33 -0700
In-Reply-To: <Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu>
Message-ID: <87znw8anje.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> Strictly speaking, there might be a DISadvantage - IIRC, there's nothing to
> stop gcc from
> #define uint8_t unsigned long long	/* it is at least 8 bits */
> ICBW, but wasn't uint<n>_t only promised to be at least <n> bits?

No.  See C99 7.18.1.1:

     7.18.1.1 Exact-width integer types

1    The typedef name intN_t designates a signed integer type with
     width N, no padding bits, and a two's complement
     representation. Thus, int8_t denotes a signed integer type
     with a width of exactly 8 bits.

2    The typedef name uintN_t designates an unsigned integer type
     with width N. Thus, uint24_t denotes an unsigned integer
     type with a width of exactly 24 bits.

3    These types are optional. However, if an implementation
     provides integer types with widths of 8, 16, 32, or 64 bits,
     it shall define the corresponding typedef names.

-- 
"To the engineer, the world is a toy box full of sub-optimized and
 feature-poor toys."
--Scott Adams
