Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSKSPHv>; Tue, 19 Nov 2002 10:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSKSPHv>; Tue, 19 Nov 2002 10:07:51 -0500
Received: from dsl-65-185-2-121.telocity.com ([65.185.2.121]:54487 "EHLO
	pele.pele.cx") by vger.kernel.org with ESMTP id <S265543AbSKSPHu>;
	Tue, 19 Nov 2002 10:07:50 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com.suse.lists.linux.kernel>
	<p738yzywzrd.fsf@oldwotan.suse.de> <20021112215437.GB1151@elf.ucw.cz>
From: Shalon Wood <dstar@pele.cx>
Date: 19 Nov 2002 09:14:31 -0600
In-Reply-To: <20021112215437.GB1151@elf.ucw.cz>
Message-ID: <873cpxzj54.fsf@pele.pele.cx>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > > I have a directory with 39,000 files in it, and I'm trying to use the cp
> > > command to copy them into another directory, and neither the cp or the
> > > mv command will work, they both same "argument list too long" when I
> > > use:
> > > 
> > > cp -f * /usr/local/www/images
> > 
> > Kind of. The * is expanded by the shell. The kernel limits the max
> > length of program arguments, which is biting you here. In theory you
> > could increase the MAX_ARG_PAGES #define in linux/binfmts.h and
> > recompile. No guarantee that it won't have any bad side effects
> > though. The default is rather low, it should be probably increased 
> > (I also regularly run into this)
> 
> I have been making that limit higher 5 years ago. Perhaps its time to
> up it for everyone?

Is this something that _must_ be set at compile time, or could it be
made tuneable via /proc?

Shalon Wood

-- 
