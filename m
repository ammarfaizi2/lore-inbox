Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSKMUYH>; Wed, 13 Nov 2002 15:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSKMUYG>; Wed, 13 Nov 2002 15:24:06 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1796 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262804AbSKMUWJ>;
	Wed, 13 Nov 2002 15:22:09 -0500
Date: Tue, 12 Nov 2002 22:54:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Adam Voigt <adam@cryptocomm.com>, linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
Message-ID: <20021112215437.GB1151@elf.ucw.cz>
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com.suse.lists.linux.kernel> <p738yzywzrd.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p738yzywzrd.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have a directory with 39,000 files in it, and I'm trying to use the cp
> > command to copy them into another directory, and neither the cp or the
> > mv command will work, they both same "argument list too long" when I
> > use:
> > 
> > cp -f * /usr/local/www/images
> 
> Kind of. The * is expanded by the shell. The kernel limits the max
> length of program arguments, which is biting you here. In theory you
> could increase the MAX_ARG_PAGES #define in linux/binfmts.h and
> recompile. No guarantee that it won't have any bad side effects
> though. The default is rather low, it should be probably increased 
> (I also regularly run into this)

I have been making that limit higher 5 years ago. Perhaps its time to
up it for everyone?
								Pavel
-- 
When do you have heart between your knees?
