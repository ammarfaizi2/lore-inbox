Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRGUXr7>; Sat, 21 Jul 2001 19:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267851AbRGUXrt>; Sat, 21 Jul 2001 19:47:49 -0400
Received: from [64.81.246.98] ([64.81.246.98]:32138 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267852AbRGUXrk>;
	Sat, 21 Jul 2001 19:47:40 -0400
Date: Sat, 21 Jul 2001 16:45:44 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: ja@himel.com, linux-kernel@vger.kernel.org
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
Message-ID: <20010721164544.B3676@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>, ja@himel.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10107181347030.16710-100000@l> <200107181510.f6IFAMW03662@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107181510.f6IFAMW03662@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 18, 2001 at 08:10:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 18, 2001 at 08:10:22AM -0700, Linus Torvalds wrote:
>  - fix _all_ the "cpuid*()" functions to have
> 
> 	:"0" (op)
> 
>    instead of their current incorrect
> 
> 	:"a" (op)
> 
>    (we're supposed to explicitly tell the compiler that the first input
>    is the same as the first output)

FWIW, using "a" as the input constraint isn't incorrect.
The two are equivalent given a singleton register class.


r~
