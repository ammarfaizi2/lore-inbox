Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbRFGAAh>; Wed, 6 Jun 2001 20:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbRFGAA1>; Wed, 6 Jun 2001 20:00:27 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:30728 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S262722AbRFGAAO>; Wed, 6 Jun 2001 20:00:14 -0400
Date: Thu, 7 Jun 2001 11:59:56 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010607115956.B27031@metastasis.f00f.org>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <9fm5cp$431$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9fm5cp$431$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jun 06, 2001 at 01:55:53PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 01:55:53PM -0700, Linus Torvalds wrote:

    In 2.4.x, you'll get it on the stack as one of the ELF auxilliary
    entries (AT_CLKTCK). 
    
    Strictly speaking that's the "frequency at which 'times()' counts", ie
    the kernel CLOCKS_PER_SEC, not HZ. But from a user perspective the two
    should hopefully always be the same (if any of the /proc fields etc
    should really use CLOCKS_PER_SEC, not HZ).

I would hope nobody actually uses the above.  Since I run kernels
with HZ==2048 and started having to hack various userland tools to
make them happy I too was after this information.

However, it was pointed out that eliminated HZ completely might be a
better idea, and then just exporting all values to userspace as
nanoseconds or similiar... a radically different approach to what we
have now but something that struck me as a really good idea.

Fodder for 2.5.x perhaps?



  --cw
