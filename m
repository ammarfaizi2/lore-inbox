Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319048AbSH1XMT>; Wed, 28 Aug 2002 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSH1XMT>; Wed, 28 Aug 2002 19:12:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319048AbSH1XMS>; Wed, 28 Aug 2002 19:12:18 -0400
Date: Thu, 29 Aug 2002 00:16:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/PATCH] : bug in tty_default_put_char()
Message-ID: <20020829001638.A28455@flint.arm.linux.org.uk>
References: <20020826180749.GA8630@bougret.hpl.hp.com> <20020826203126.C4763@flint.arm.linux.org.uk> <20020826195346.GC8749@bougret.hpl.hp.com> <20020826210159.E4763@flint.arm.linux.org.uk> <20020826201732.GE8749@bougret.hpl.hp.com> <20020826212223.H4763@flint.arm.linux.org.uk> <20020828224103.GC12472@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020828224103.GC12472@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Wed, Aug 28, 2002 at 03:41:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 03:41:03PM -0700, Jean Tourrilhes wrote:
> 	Patch below allow to set "uart=none", which is necessary for
> FIR hardware. Patch for 2.5.31.

Ok, thanks.

> 	The write is comming from the PPP line discipline. If PPP
> can't transmit the data, it just drops it and assume higher layers
> will retry. This is true for TCP, but not for "chat".

Last time I read the pppd code, chat doesn't talk via the ppp code, but
via the serial device itself.  I'm still confused about this report,
since it could mean something is very wrong somewhere and not knowing
where is really bugging me.  I really don't like sleeping problems that
come back to bite later.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

