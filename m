Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVAYGUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVAYGUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVAYGUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:20:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:12263 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261834AbVAYGUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:20:14 -0500
Date: Mon, 24 Jan 2005 22:18:48 -0800
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [1/1] superio: change scx200 module name to scx.
Message-ID: <20050125061848.GB2215@kroah.com>
References: <20050124233720.484c7ad0@zanzibar.2ka.mipt.ru> <29495f1d05012413415c66974b@mail.gmail.com> <20050125011330.3b4b8611@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125011330.3b4b8611@zanzibar.2ka.mipt.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 01:13:30AM +0300, Evgeniy Polyakov wrote:
> On Mon, 24 Jan 2005 13:41:33 -0800
> Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> 
> > > +               set_current_state(TASK_INTERRUPTIBLE);
> > > +               schedule_timeout(HZ);
> > > +
> > > +               if (current->flags & PF_FREEZE)
> > > +                       refrigerator(PF_FREEZE);
> > > +
> > > +               if (signal_pending(current))
> > > +                       flush_signals(current);
> > > +       }
> > 
> > <snip>
> > 
> > I believe this schedule_timeout() call can be an msleep_interruptible(1000).
> 
> Patch was already sent to Greg, it will be included in next release.
> Attached one with fixed scx200/scx filename.

Applied, thanks.

greg k-h
