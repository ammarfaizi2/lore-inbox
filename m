Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbSKSThS>; Tue, 19 Nov 2002 14:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbSKSThS>; Tue, 19 Nov 2002 14:37:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53767 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267141AbSKSThR>; Tue, 19 Nov 2002 14:37:17 -0500
Date: Tue, 19 Nov 2002 20:44:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Shalon Wood <dstar@pele.cx>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
Message-ID: <20021119194420.GB7219@atrey.karlin.mff.cuni.cz>
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com.suse.lists.linux.kernel> <p738yzywzrd.fsf@oldwotan.suse.de> <20021112215437.GB1151@elf.ucw.cz> <873cpxzj54.fsf@pele.pele.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cpxzj54.fsf@pele.pele.cx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 
> > > > I have a directory with 39,000 files in it, and I'm trying to use the cp
> > > > command to copy them into another directory, and neither the cp or the
> > > > mv command will work, they both same "argument list too long" when I
> > > > use:
> > > > 
> > > > cp -f * /usr/local/www/images
> > > 
> > > Kind of. The * is expanded by the shell. The kernel limits the max
> > > length of program arguments, which is biting you here. In theory you
> > > could increase the MAX_ARG_PAGES #define in linux/binfmts.h and
> > > recompile. No guarantee that it won't have any bad side effects
> > > though. The default is rather low, it should be probably increased 
> > > (I also regularly run into this)
> > 
> > I have been making that limit higher 5 years ago. Perhaps its time to
> > up it for everyone?
> 
> Is this something that _must_ be set at compile time, or could it be
> made tuneable via /proc?

Probably can be made tuneable, but I've nonot seen a patch...

				Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
