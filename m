Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVKAHvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVKAHvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVKAHvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:51:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:6091 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932423AbVKAHvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:51:35 -0500
Date: Mon, 31 Oct 2005 23:35:30 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, rml@novell.com
Subject: Re: Kernel Badness 2.6.14-Git
Message-ID: <20051101073530.GB27536@kroah.com>
References: <4362BFF1.3040304@linuxwireless.org> <20051029031706.GA26123@kroah.com> <200510312221.13217.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510312221.13217.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 10:21:12PM -0500, Dmitry Torokhov wrote:
> On Friday 28 October 2005 22:17, Greg KH wrote:
> > On Fri, Oct 28, 2005 at 06:18:57PM -0600, Alejandro Bonilla Beeche wrote:
> > > Hi,
> > > 
> > >    I just pulled from Linus Tree and I'm getting this badness in dmesg.
> > > 
> > > Please let me know if it is too soon to start reporting this. 2.6.14 is 
> > > OK and does not output this.
> > 
> > If you disable PNP does it go away?
> > 
> > Dmitry, any thoughts?  This looks like the other reported issue.
> >
> 
> I was looking and looking and the only thing I could come up with is
> that we probably need to initialize input core earlier, before other
> modules had a chance to use input interface so input class is fully
> initialized. We don't need to have input/{ev|mouse|ts|joy}dev.o,
> just input/input.o itself.

Then why not move this input driver into a different directory so it
doesn't cause this issue?

Robert?
