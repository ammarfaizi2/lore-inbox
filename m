Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSLJPbx>; Tue, 10 Dec 2002 10:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLJPbx>; Tue, 10 Dec 2002 10:31:53 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:9185 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S262224AbSLJPbw>; Tue, 10 Dec 2002 10:31:52 -0500
Date: Tue, 10 Dec 2002 16:35:34 +0100
From: Stelian Pop <stelian@popies.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.20-BK] make new ide compile
Message-ID: <20021210163534.H18849@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021210154904.E18849@deep-space-9.dsnet> <1039536420.14166.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039536420.14166.5.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 10, 2002 at 04:07:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 04:07:00PM +0000, Alan Cox wrote:

> On Tue, 2002-12-10 at 14:49, Stelian Pop wrote:
> > ===== include/linux/ide.h 1.7 vs edited =====
> > --- 1.7/include/linux/ide.h	Fri Nov 29 23:03:01 2002
> > +++ edited/include/linux/ide.h	Tue Dec 10 12:20:01 2002
> > @@ -1755,5 +1755,8 @@
> >  #define ide_lock		(io_request_lock)
> >  #define DRIVE_LOCK(drive)       ((drive)->queue.queue_lock)
> >  
> > +#define local_save_flags(flags)	save_flags((flags))
> > +#define save_and_cli(x)		local_irq_save(x)
> > +#define local_irq_set(flags)    do { local_save_flags((flags)); local_irq_enable(); } while (0)
> >  
> 
> Please don't apply these changes. Use the ones from -ac

As I said, it is just the dirty patch making it compile (and run),
while waiting for the proper fix.

It was never intended for integration in any tree, of course :-)

Stelian.
-- 
Stelian Pop <stelian@popies.net>
