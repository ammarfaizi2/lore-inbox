Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSJQIWH>; Thu, 17 Oct 2002 04:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSJQIWH>; Thu, 17 Oct 2002 04:22:07 -0400
Received: from zero.aec.at ([193.170.194.10]:5131 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261853AbSJQIWG>;
	Thu, 17 Oct 2002 04:22:06 -0400
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Device-mapper submission 6/7
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk>
	<3DAC5B47.7020206@pobox.com>
	<20021015214420.GA28738@fib011235813.fsnet.co.uk>
	<3DAD75AE.7010405@pobox.com>
	<20021016152047.GA11422@fib011235813.fsnet.co.uk>
	<3DAD8CC9.9020302@pobox.com>
	<20021017080552.GA2418@fib011235813.fsnet.co.uk>
From: Andi Kleen <ak@muc.de>
Date: 17 Oct 2002 10:26:44 +0200
In-Reply-To: <20021017080552.GA2418@fib011235813.fsnet.co.uk>
Message-ID: <m3fzv5pj23.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <joe@fib011235813.fsnet.co.uk> writes:

> Is there anyone out there who is going to argue against using an fs
> interface when I submit it ?  Speak now or forever hold your peace !
> 
> If dm now misses the feature freeze deadline due to this extra work,
> is it going to be possible to still place it in 2.5 at a later date ?
> (dm with an ioctl interface is better than no dm at all).

How would the fs based interface work ? 

plan9 style echo 'rename foo bla' > /dmfs/command would seem ugly to me
(just look at the horrible parser code for that in mtrr.c) 

doing it fully as fs objects (mv /dmfs/volume1 /dmfs/volume2 for rename)
could likely get complicated and it's doubtful that VFS semantics completely
map to DM volumes.

Unless you have a clear and simple way to handle these issues I would
suggest to stay with simple ioctls. They look clean enough.

-Andi


