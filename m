Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSCRPWx>; Mon, 18 Mar 2002 10:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSCRPWm>; Mon, 18 Mar 2002 10:22:42 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:21972 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S290713AbSCRPWa>; Mon, 18 Mar 2002 10:22:30 -0500
Date: Mon, 18 Mar 2002 15:22:14 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
Message-ID: <20020318152214.A523@kushida.apsleyroad.org>
In-Reply-To: <20020317020145.A20307@kushida.apsleyroad.org> <Pine.LNX.4.33.0203180938060.9609-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:
> > As long as __SLOW_DOWN_IO_PORT is a simple constant, you can just use
> > this instead:
> >
> >     #define __SLOW_DOWN_IO_ASM	"\noutb %%al,$" #__SLOW_DOWN_IO_PORT
> 
> What cpp are you guys using? Mine does stringification (#s) only with
> arguments of function-like macros.

You're right, my error.  You need to use an argument, as has already
been pointed out -- <linux/stringify.h>.

-- Jamie
