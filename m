Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCCQZS>; Sat, 3 Mar 2001 11:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRCCQZJ>; Sat, 3 Mar 2001 11:25:09 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:51980 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129598AbRCCQYv>;
	Sat, 3 Mar 2001 11:24:51 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Sat, 3 Mar 2001 16:24:30 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
Message-ID: <20010303162346.A1250@flint.arm.linux.org.uk>
In-Reply-To: <200103031249.f23Cn4R01208@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103031249.f23Cn4R01208@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Mar 03, 2001 at 12:49:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2001 at 12:49:04PM +0000, Russell King wrote:
> Further more, while do_gettimeofday() is still within the
> read_lock_irqsave, we spin_unlock(&i8253_lock) in do_slow_gettimeoffset()
> and _re-enable_ interrupts!  This means when we later read xtime, we're
> doing it with interrupts enabled.

Ok, so this is a classic brainfart.  The rest of the original message still
stands though.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

