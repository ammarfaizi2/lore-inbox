Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290592AbSA3VB5>; Wed, 30 Jan 2002 16:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSA3VBr>; Wed, 30 Jan 2002 16:01:47 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:25354 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290592AbSA3VBf>; Wed, 30 Jan 2002 16:01:35 -0500
Date: Wed, 30 Jan 2002 21:01:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Alex Khripin <akhripin@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: BKL in tty code?
Message-ID: <20020130210127.H19292@flint.arm.linux.org.uk>
In-Reply-To: <20020130184950.GA22442@morgoth.mit.edu> <1012418760.3219.43.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012418760.3219.43.camel@phantasy>; from rml@tech9.net on Wed, Jan 30, 2002 at 02:25:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:25:59PM -0500, Robert Love wrote:
> It has less to do with lock contention and much more to do with the
> design of the tty / console layer.  It isn't the kernel's prettiest
> code.
> 
> There is probably some cleanup that is possible, but really getting the
> thing in gear (which means no BKL, which is probably the hardest part to
> rip out) require some level of rewrite.

I've been thinking about the serial layer, and its far from trivial.
Unless its done right, we'll end up with a mess of locks -> deadlock.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

