Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWJ3F47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWJ3F47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 00:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWJ3F47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 00:56:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:10906 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161109AbWJ3F46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 00:56:58 -0500
Date: Sun, 29 Oct 2006 21:56:28 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3-mm1
Message-ID: <20061030055628.GA5033@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <20061030025000.GA8896@redhat.com> <20061030035430.GA4045@kroah.com> <20061029211604.41114b13.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029211604.41114b13.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 09:16:04PM -0800, Andrew Morton wrote:
> On Sun, 29 Oct 2006 19:54:30 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Sun, Oct 29, 2006 at 09:50:00PM -0500, Dave Jones wrote:
> > > On Sun, Oct 29, 2006 at 04:00:02PM -0800, Andrew Morton wrote:
> > > 
> > >  > - For some reason Greg has resurrected the patches which detect whether
> > >  >   you're using old versions of udev and if so, punish you for it.
> > >  > 
> > >  >   If weird stuff happens, try upgrading udev.
> > > 
> > > Where "old" is how old exactly ?
> > 
> > As per the Kconfig help entry, any version of udev released before 2006
> > will probably have problems with the new config option.  So follow the
> > text and enable the option if you are running an old version of udev and
> > you should be fine.
> 
> <hunts>
> 
> Greg is referring to CONFIG_SYSFS_DEPRECATED.  I didn't know it existed. 
> If I had known I'd have saved maybe an hour and I perhaps wouldn't have had
> to revert gregkh-driver-tty-device.patch

Don't you run 'make oldconfig'?  :)

> What mailing list was this discussed and reviewed on?

None so far, I didn't think a "enable old, obsolete versions of udev to
still work properly" config option would be all that controversial.

> The option should default to "y".

Ok, will change it.

> The changelog is wrong.  Or garbled.  Certainly confusing.

Oops, you are right, the text in the changelog conflicts with the
reality in the Kconfig entry.  I'll fix that up.  The Kconfig text is
correct.

thanks,

greg k-h
