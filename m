Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317315AbSGXOWg>; Wed, 24 Jul 2002 10:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317314AbSGXOWg>; Wed, 24 Jul 2002 10:22:36 -0400
Received: from [195.223.140.120] ([195.223.140.120]:10571 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317315AbSGXOWf>; Wed, 24 Jul 2002 10:22:35 -0400
Date: Wed, 24 Jul 2002 16:26:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020724142630.GP1117@dualathlon.random>
References: <20020723192052.GF1117@dualathlon.random> <Pine.GSO.3.96.1020724160738.27732A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020724160738.27732A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 04:19:41PM +0200, Maciej W. Rozycki wrote:
>  I meant something explicit like that:
> 
> #ifdef CONFIG_X86_CMPXCHG8B
> 	if (!cpu_has_cx8)
> 		panic("Kernel compiled for Pentium+, requires CMPXCHG8B
> 		      feature!");
> #endif
> 
> An oops would be quite an obscure response for a configuration error.  As

I'm not sure if we catch all the config errors at runtime anyways, and
the oops is simple enough to decode (the eip will point to the
cmpxchg8b), but ok, the panic is trivial enough that it worth it.

as for the config option I just added it to close the 486+SMP case.

Andrea
