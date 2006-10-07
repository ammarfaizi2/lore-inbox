Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWJGLXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWJGLXO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 07:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWJGLXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 07:23:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26387 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750878AbWJGLXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 07:23:13 -0400
Date: Sat, 7 Oct 2006 11:23:01 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Michael Buesch <mb@bu3sch.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Message-ID: <20061007112301.GB4277@ucw.cz>
References: <200610052059.11714.mb@bu3sch.de> <1160085480.1607.32.camel@localhost.localdomain> <200610061644.33267.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610061644.33267.mb@bu3sch.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> > > Besides that, I currently don't see a valid reason to mmap address 0.
> > > 
> > > Comments?
> > 
> > User zero is not neccessarily mapped at kernel zero so your argument
> > isn't portable either.
> 
> Eh, so what about the following.
> We _have_ arches which map user zero to kernel zero. What about
> specialcasing that on a per-arch case. So remapping user zero to
> something else in kernel.

Just add some magic constant on architectures you care about... make
user 0 start at 4mb in kernel... and you get your security hardened
kernel w/o breaking dosemu. All you need is to create a patch :-)


-- 
Thanks for all the (sleeping) penguins.
