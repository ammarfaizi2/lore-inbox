Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbUKDUcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbUKDUcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUKDUL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:11:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:4747 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262376AbUKDUIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:08:46 -0500
Date: Thu, 4 Nov 2004 12:07:09 -0800
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, herbert@gondor.apana.org.au,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch] kobject_uevent: fix init ordering
Message-ID: <20041104200709.GB21149@kroah.com>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com> <20041104180550.GA16744@kroah.com> <1099592851.31022.145.camel@betsy.boston.ximian.com> <1099596532.31022.151.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099596532.31022.151.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 02:28:52PM -0500, Robert Love wrote:
> On Thu, 2004-11-04 at 13:27 -0500, Robert Love wrote:
> 
> > Looks like kobject_uevent_init is executed before netlink_proto_init and
> > consequently always fails.  Not cool.
> > 
> > Attached patch switches the initialization over from core_initcall (init
> > level 1) to postcore_initcall (init level 2).  Netlink's initialization
> > is done in core_initcall, so this should fix the problem.  We should be
> > fine waiting until postcore_initcall.
> > 
> > Also a couple white space changes mixed in, because I am anal.
> 
> Greg, sir, here is a patch rediff'ed off current BK.

"Sir"?  Geesh, I'm not that old looking am I?  :)

applied, thanks.

greg k-h
