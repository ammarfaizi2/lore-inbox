Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTIYXBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTIYXBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:01:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:55213 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261586AbTIYXBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:01:31 -0400
Date: Thu, 25 Sep 2003 15:44:47 -0700
From: Greg KH <greg@kroah.com>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in vanilla 2.4.22 serial-usb driver
Message-ID: <20030925224447.GB30186@kroah.com>
References: <87llsdy01v.fsf@ceramic.fifi.org> <20030925185039.GB29088@kroah.com> <87eky4hauq.fsf@ceramic.fifi.org> <20030925210104.GB29680@kroah.com> <87ad8sh54y.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ad8sh54y.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 03:31:25PM -0700, Philippe Troin wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Thu, Sep 25, 2003 at 01:27:57PM -0700, Philippe Troin wrote:
> > > > > BTW, is there any way to restart khubd without rebooting?
> > > > 
> > > > Nope, sorry.
> > > 
> > > Are there any technical reasons behind that, or that just that it is
> > > not implemented?
> > 
> > It's a bit hard to restart a kernel thread that is oopsed :)
> 
> Yes, but still, with a completely modular USB subsystem, removing all
> the modules and reinsrting them (when possible) restarts khubd... So
> if it is possible with modules, it ought to be possible with
> monolithic USB...

Usually when khubd oopses like this, a usb module is stuck with a
incremented reference count which prevents the usbcore from being able
to be unloaded.

But hey, patches are always accepted :)

thanks,

greg k-h
