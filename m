Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315469AbSEHWtX>; Wed, 8 May 2002 18:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315446AbSEHWtW>; Wed, 8 May 2002 18:49:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21523 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315469AbSEHWtM>; Wed, 8 May 2002 18:49:12 -0400
Date: Thu, 9 May 2002 00:49:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: seasons@falcon.sch.bme.hu, linux-kernel@vger.kernel.org
Subject: Re: kernel/swsusp.c doesn't compile with modular IDE
Message-ID: <20020508224915.GD11385@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.NEB.4.44.0205082225030.19321-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> kernel/swsusp.c in 2.4.19-pre8-ac1 includes:
> 
> <--  snip  -->
> 
> ...
> #ifdef CONFIG_BLK_DEV_IDE
>         ide_disk_suspend();
> #else
> #error Are you sure your disk driver supports suspend?
> #endif
> ...
> 
> <--  snip  -->
> 
> 
> You hit the #error when you try to compile swsusp into a kernel with a
> completely modular IDE.

Hmm, too bad. I guess we need driver model for that.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
