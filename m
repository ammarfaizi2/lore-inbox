Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRB0R4D>; Tue, 27 Feb 2001 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRB0Rzx>; Tue, 27 Feb 2001 12:55:53 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:5384 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129694AbRB0Rzg>; Tue, 27 Feb 2001 12:55:36 -0500
Date: Tue, 27 Feb 2001 11:55:26 -0600
To: Ivan Stepnikov <iv@spylog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory allocation
Message-ID: <20010227115526.A19593@cadcamlab.org>
In-Reply-To: <004901c0a0de$2647d6c0$0e04a8c0@iv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <004901c0a0de$2647d6c0$0e04a8c0@iv>; from iv@spylog.com on Tue, Feb 27, 2001 at 07:55:54PM +0300
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Ivan Stepnikov]
> I tried to call getrlimit(). It shows only 2G available memory and
> there is no way to increase it.

Right.  Architectural limit.  There needs to be some room in the
address space for kernel stuff, I/O, etc -- in Linux at least, having
to play with your page tables every single time you enter a system call
or IRQ handler would be considered a Bad Thing.

> Could you say me are there any solutions?

a) If you have that much memory, maybe you need a 64-bit CPU.
b) fork() and do IPC.  It's the Unix Way.

Peter
