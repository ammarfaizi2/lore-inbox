Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261986AbSI3JoK>; Mon, 30 Sep 2002 05:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261989AbSI3JoJ>; Mon, 30 Sep 2002 05:44:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45069 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261986AbSI3JoJ>; Mon, 30 Sep 2002 05:44:09 -0400
Date: Mon, 30 Sep 2002 10:49:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tim Waugh <twaugh@redhat.com>
Cc: Marek Michalkiewicz <marekm@amelek.gda.pl>, serial24@macrolink.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
Message-ID: <20020930104928.C5119@flint.arm.linux.org.uk>
References: <E17uesu-0002dE-00@mm.lan.amelek.gda.pl> <20020930094012.GC20605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020930094012.GC20605@redhat.com>; from twaugh@redhat.com on Mon, Sep 30, 2002 at 10:40:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 10:40:12AM +0100, Tim Waugh wrote:
> On Thu, Sep 26, 2002 at 10:05:16PM +0200, Marek Michalkiewicz wrote:
> > below is a patch that moves parport_serial.c from drivers/parport/
> > to drivers/char/ - this fixes the wrong link order when the drivers
> > are compiled into the kernel.
> 
> What was wrong with the original, much smaller patch that you sent me
> previously (below)?
> 
> I'm happy to accept whichever patch is the better.

Other than it's a gross hack rather than a fix.  However, for 2.4, I
think this is probably the best solution without creating a risk of
other init ordering problems.  Ed, any comments?

In 2.5, its easier to solve; we just need to make sure serial is
initialised before parport.  This is easy, since serial now has its
own drivers/serial subdirectory.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

