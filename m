Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268173AbTCFQpB>; Thu, 6 Mar 2003 11:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268174AbTCFQpB>; Thu, 6 Mar 2003 11:45:01 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:29929 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S268173AbTCFQo6>; Thu, 6 Mar 2003 11:44:58 -0500
Date: Thu, 6 Mar 2003 17:55:24 +0100
From: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Tino Keitel <tino.keitel@innominate.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Slow system after switching from 2.4.18 to 2.4.19
Message-ID: <20030306165524.GB13619@wohnheim.fh-wedel.de>
References: <20030306153515.GB2166@tkeitel001.bln.gelonet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030306153515.GB2166@tkeitel001.bln.gelonet.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 March 2003 16:35:15 +0100, Tino Keitel wrote:
> 
> after updating to 2.4.19, my system (Intel XScale based, 500 MHz, 16 MB
> flash, 32 MB RAM) was awfully slow. I suspect the reason is a slow
> access to the filesystem. As soon as something happens on the
> filesystem, e.g. in shell scripts, runtimes are multimple times higher
> than with 2.4.18. A short example what happens with the 2.4.19 kernel:
> 
> (1)
> for i in 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
> 	do echo "nothing" > /dev/null ;
> done
> 
> takes 2 seconds(!), just for 30 echos.
> 
> (2)
> for i in 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
> 	do true;
> done
> 
> returns immediately because 'true' is a shell builtin and no filesystem
> access is necessary. With the 2.4.18 kernel, (1) also doesn't take
> sensible time to complete. Of course, the configuration is the same
> with both kernels. Any hints?

Only that mtd is likely not the cause. :)

Maybe someone on lkml known more...

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
