Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVA1OzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVA1OzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVA1OzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:55:18 -0500
Received: from ns.suse.de ([195.135.220.2]:44996 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261440AbVA1OzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:55:12 -0500
Date: Fri, 28 Jan 2005 15:55:11 +0100
From: Olaf Hering <olh@suse.de>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Message-ID: <20050128145511.GA29340@suse.de>
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de> <d120d50005012806435a17fe98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d120d50005012806435a17fe98@mail.gmail.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jan 28, Dmitry Torokhov wrote:

> On Fri, 28 Jan 2005 14:58:27 +0100, Olaf Hering <olh@suse.de> wrote:
> > On Fri, Jan 28, Olaf Hering wrote:
> > 
> > >
> > > My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> > 
> > It fails also on PReP, not only on CHRP. 2.6.10 looks like this:
> > 
> > Calling initcall 0xc03bc430: atkbd_init+0x0/0x2c()
> > atkbd.c: keyboard reset failed on isa0060/serio1
> > atkbd.c: keyboard reset failed on isa0060/serio0
> >
> 
> So it could not reset it even before, but it was not getting stuch
> tough... What about passing atkbd.reset=0?

I will try that.
Adding a printk after the outb() fixes it as well. 
Do you have a version of that i8042 delay patch for 2.6.11-rc2-bk6?
Maybe it will help.
