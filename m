Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbSKONJ6>; Fri, 15 Nov 2002 08:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKONJ6>; Fri, 15 Nov 2002 08:09:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31751 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266200AbSKONJ5>; Fri, 15 Nov 2002 08:09:57 -0500
Date: Fri, 15 Nov 2002 13:16:45 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
Message-ID: <20021115131645.A2168@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <p73wunfv5b0.fsf@oldwotan.suse.de> <20021115084757.A640A2C145@lists.samba.org> <20021115045146.A23944@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115045146.A23944@twiddle.net>; from rth@twiddle.net on Fri, Nov 15, 2002 at 04:51:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 04:51:46AM -0800, Richard Henderson wrote:
> to be used like so
> 
> 	ld -T z.ld -shared -o z.so z.o

I'm slightly worried about this.  For things like shared libraries to be
relocatable on ARM on current toolchains, you need to build with -fPIC.
This introduces a measurable overhead to all code execution which our
current model does not.  (Namely all symbol references go via the GOT
table.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
