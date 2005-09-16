Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVIPWiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVIPWiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVIPWiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:38:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:2207 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750734AbVIPWiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:38:55 -0400
Date: Fri, 16 Sep 2005 15:32:14 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, dtor_core@ameritech.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, caphrim007@gmail.com, david-b@pacbell.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Lost keyboard on Inspiron 8200 at 2.6.13
Message-ID: <20050916223214.GA14637@kroah.com>
References: <432A4A1F.3040308@gmail.com> <200509152357.58921.dtor_core@ameritech.net> <20050916025356.0d5189a6.akpm@osdl.org> <d120d500050916082519c660e6@mail.gmail.com> <1126886449.17038.4.camel@localhost.localdomain> <20050916184440.GA11413@kroah.com> <20050916152432.5a05aeca.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916152432.5a05aeca.zaitcev@redhat.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 03:24:32PM -0700, Pete Zaitcev wrote:
> On Fri, 16 Sep 2005 11:44:40 -0700, Greg KH <greg@kroah.com> wrote:
> > On Fri, Sep 16, 2005 at 05:00:49PM +0100, Alan Cox wrote:
> > > On Gwe, 2005-09-16 at 10:25 -0500, Dmitry Torokhov wrote:
> 
> > Only if we merge the code that does the handoff, with the same code that
> > does it in the usb core, would I feel more comfortable to enable this
> > always.  I had a patch from David Brownell to do this, but it had some
> > link errors at times, so I had to drop it :(
> 
> I see why you would want to merge them, but is it worth the trouble?

We've already divered from the original code, which was identical.
People forget to fix the other instance, when then change one of them.

> They are not identical. For one thing, early handoff installs its own
> fake interrupt handlers (Alan Cox insisted on it in the RHEL
> implementation).

The interrupt handlers aren't an issue.  It's how the handoff happens at
a hardware level that is.  I just want to make sure any changes made to
one place, make it to the other place.

thanks,

greg k-h
