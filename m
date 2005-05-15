Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVEOJH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVEOJH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVEOJH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:07:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54937 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261569AbVEOJHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:07:25 -0400
Date: Sun, 15 May 2005 11:07:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Message-ID: <20050515090705.GA2343@elf.ucw.cz>
References: <200505132117.37461.arnd@arndb.de> <200505132129.07603.arnd@arndb.de> <1116027079.5128.32.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116027079.5128.32.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > /run	A stub file that lets us do ioctl. The only ioctl
> > 	method we need is the spu_run() call. spu_run suspends
> > 	the current thread from the host CPU and transfers
> > 	the flow of execution to the SPU.
> > 	The ioctl call return to the calling thread when a state
> > 	is entered that can not be handled by the kernel, e.g.
> > 	an error in the SPU code or an exit() from it.
> > 	When a signal is pending for the host CPU thread, the
> > 	ioctl is interrupted and the SPU stopped in order to
> > 	call the signal handler.
> 
> ioctl's are generally considered evil ... what about a write() method
> writing a command ?

That's even more evil than ioctl()... Try doing 32-vs-64bit conversion
on write...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
