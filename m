Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVKAIPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVKAIPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVKAIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:14:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:54484 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965041AbVKAIOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:52 -0500
Date: Tue, 1 Nov 2005 00:14:33 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, rml@novell.com
Subject: Re: Kernel Badness 2.6.14-Git
Message-ID: <20051101081433.GB28048@kroah.com>
References: <4362BFF1.3040304@linuxwireless.org> <200510312221.13217.dtor_core@ameritech.net> <20051101073530.GB27536@kroah.com> <200511010258.14313.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511010258.14313.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 02:58:13AM -0500, Dmitry Torokhov wrote:
> On Tuesday 01 November 2005 02:35, Greg KH wrote:
> > On Mon, Oct 31, 2005 at 10:21:12PM -0500, Dmitry Torokhov wrote:
> > > On Friday 28 October 2005 22:17, Greg KH wrote:
> > > > On Fri, Oct 28, 2005 at 06:18:57PM -0600, Alejandro Bonilla Beeche wrote:
> > > > > Hi,
> > > > > 
> > > > >    I just pulled from Linus Tree and I'm getting this badness in dmesg.
> > > > > 
> > > > > Please let me know if it is too soon to start reporting this. 2.6.14 is 
> > > > > OK and does not output this.
> > > > 
> > > > If you disable PNP does it go away?
> > > > 
> > > > Dmitry, any thoughts?  This looks like the other reported issue.
> > > >
> > > 
> > > I was looking and looking and the only thing I could come up with is
> > > that we probably need to initialize input core earlier, before other
> > > modules had a chance to use input interface so input class is fully
> > > initialized. We don't need to have input/{ev|mouse|ts|joy}dev.o,
> > > just input/input.o itself.
> > 
> > Then why not move this input driver into a different directory so it
> > doesn't cause this issue?
> >
> 
> Can't we move just input.o closer to the top of drivers/Makefile? It is
> kinda silly to have a subdirectory with only one file. And I would move
> serio.o there as well.

I don't have a problem with this, try it out and see what breaks :)

thanks,

greg k-h
