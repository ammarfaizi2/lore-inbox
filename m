Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270199AbRHSH2R>; Sun, 19 Aug 2001 03:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270201AbRHSH16>; Sun, 19 Aug 2001 03:27:58 -0400
Received: from are.twiddle.net ([64.81.246.98]:4263 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S270199AbRHSH1p>;
	Sun, 19 Aug 2001 03:27:45 -0400
Date: Sun, 19 Aug 2001 00:13:44 -0700
From: Richard Henderson <rth@twiddle.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010819001344.C29533@twiddle.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1904.997542180@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1904.997542180@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Aug 12, 2001 at 01:03:00AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 01:03:00AM +1000, Keith Owens wrote:
>     asm volatile("\n-> " #sym " %c0 " #val " " #marker : : "i" (val))

This is bad -- 'c' requests an address constant (CONSTANT_ADDRESS_P
if you're playing from home), and as defined this constant must be
valid in an instruction.

Such things are by nature target specific.  On ia64, for instance,
there are *no* valid address constants, since all valid memory
addresses are simple registers.

You can do what you want here with just "%0".


r~
