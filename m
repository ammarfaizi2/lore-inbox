Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbUKQSPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUKQSPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUKQSLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:11:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:45696 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262480AbUKQSJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:09:10 -0500
Date: Wed, 17 Nov 2004 09:55:05 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041117175504.GE28285@kroah.com>
References: <20041109223729.GB7416@kroah.com> <d120d50004111612437ebe76d9@mail.gmail.com> <20041116230828.GB16690@kroah.com> <200411170200.32860.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411170200.32860.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 02:00:32AM -0500, Dmitry Torokhov wrote:
> On Tuesday 16 November 2004 06:08 pm, Greg KH wrote:
> > On Tue, Nov 16, 2004 at 03:43:21PM -0500, Dmitry Torokhov wrote:
> > > On Mon, 15 Nov 2004 21:54:40 -0800, Greg KH <greg@kroah.com> wrote:
> > > > On Tue, Nov 09, 2004 at 10:49:43PM -0500, Dmitry Torokhov wrote:
> > > > > In the meantime, can I please have bind_mode patch applied? I believe
> > > > > it is useful regardless of which bind/unbind solution will be adopted
> > > > > and having them will allow me clean up serio bus implementaion quite a
> > > > > bit.
> > > > >
> > > > > Pretty please...
> > > > 
> > > > Care to resend it?  I can't find it in my archives.
> > > > 
> > > 
> > > Here it is, against 2.6.10-rc2. Apologies for sending it as an attachment
> > > but this interface will not let me put it inline without mangling.
> > 
> > No, for now, if you want to do this, do it in the serio code only, let's
> > clean up the locking first before we do this in the core.
> > 
> 
> *confused* This patch is completely independent from any locking issues in
> driver core...

I agree, it's a convient excuse to use to keep any other driver core
changes from happening right now :)

> It is just 2 flags in device and driver structures that are checked in
> device_attach and driver_attach.

But I'm not so sure we want to add this to the driver core yet.  We can
discuss this after the locking stuff is finished, ok?

thanks,

greg k-h
