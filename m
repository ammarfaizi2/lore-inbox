Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUAPTQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbUAPTQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:16:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:6804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265609AbUAPTQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:16:25 -0500
Date: Fri, 16 Jan 2004 11:17:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs class support for vc devices [10/10]
Message-Id: <20040116111738.74636496.akpm@osdl.org>
In-Reply-To: <1074279897.23742.754.camel@nosferatu.lan>
References: <20040115204048.GA22199@kroah.com>
	<20040115204111.GB22199@kroah.com>
	<20040115204125.GC22199@kroah.com>
	<20040115204138.GD22199@kroah.com>
	<20040115204153.GE22199@kroah.com>
	<20040115204209.GF22199@kroah.com>
	<20040115204241.GG22199@kroah.com>
	<20040115204259.GH22199@kroah.com>
	<20040115204311.GI22199@kroah.com>
	<20040115204329.GJ22199@kroah.com>
	<20040115204356.GK22199@kroah.com>
	<20040115201358.75ffc660.akpm@osdl.org>
	<1074279897.23742.754.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer <azarah@nosferatu.za.org> wrote:
>
> On Fri, 2004-01-16 at 06:13, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > This patch add sysfs support for vc char devices.
> > > 
> > >  Note, Andrew Morton has reported some very strange oopses with this
> > >  patch, that I can not reproduce at all.  If anyone else also has
> > >  problems with this patch, please let me know.
> > 
> > It seems to have magically healed itself :(
> > 
> > Several people were hitting it.  We shall see.
> 
> Might it be due to the vt-locking-fixes patch?
> 

No, I was able to reproduce the oops with just two of Greg's patches on
bare 2.6.1-rcX.

It was some refcounting problem in the tty layer.  100% deterministic, not
a race.

