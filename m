Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319434AbSH3FdO>; Fri, 30 Aug 2002 01:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319432AbSH3FdO>; Fri, 30 Aug 2002 01:33:14 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:7570 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319431AbSH3FdM>;
	Fri, 30 Aug 2002 01:33:12 -0400
Date: Fri, 30 Aug 2002 07:37:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: input u-cleanup
Message-ID: <20020830073728.B18904@ucw.cz>
References: <20020828220603.GA30107@elf.ucw.cz> <20020829081736.A23935@ucw.cz> <20020829222642.GB16986@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020829222642.GB16986@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Fri, Aug 30, 2002 at 12:26:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 12:26:42AM +0200, Pavel Machek wrote:

> > > proc is clever enough not to need ifdefs, so this is probably good
> > > idea...
> > > 
> > > 								Pavel
> > 
> > If you could remove all the procfs #ifdefs from input.c, that'd be great.
> > But removing only those around unregistration IMHO doesn't make
> > > sense.
> 
> 
> They can be safely dropped. I had patch to do that but droped it during
> merge. If you'll accept complete patch, I'll create it.   [Or you can
> do it yourself, just killing #ifdef CONFIG_PROC_FS should do the
> trick].

Yes, but a lot of functions unneeded without CONFIG_PROC_FS will remain
linked in ... if you manage it down to one #ifdef, just around the
functions, I'll take it.

-- 
Vojtech Pavlik
SuSE Labs
