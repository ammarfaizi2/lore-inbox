Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRLRQxK>; Tue, 18 Dec 2001 11:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284220AbRLRQxB>; Tue, 18 Dec 2001 11:53:01 -0500
Received: from zeus.kernel.org ([204.152.189.113]:31645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S280410AbRLRQwt>;
	Tue, 18 Dec 2001 11:52:49 -0500
Date: Tue, 18 Dec 2001 16:48:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Telford002@aol.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TTY Driver Open and Close Logic
Message-ID: <20011218164840.B13126@flint.arm.linux.org.uk>
In-Reply-To: <e5.10e6703a.29509786@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <e5.10e6703a.29509786@aol.com>; from Telford002@aol.com on Tue, Dec 18, 2001 at 07:58:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 07:58:46AM -0500, Telford002@aol.com wrote:
> I have been working on various serial drivers and I notice that physical
> driver close routine is called in all cases even if the physical driver
> open routine fails.  That suggests to me that a lot of the MOD_DEC/INC_COUNT
> logic in serial.c and other physical serial drivers is incorrect.  As
> serial.c seems usually to be compiled into the kernel the issue
> is not so important, but a lot of the other logic associated with
> open counts also seems incorrect.  Is this observation correct?

Absolutely 100% correct.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

