Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVBCBOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVBCBOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVBCBEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:04:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:21890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262863AbVBCAa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:30:26 -0500
Date: Wed, 2 Feb 2005 16:30:10 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Roskin <proski@gnu.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050203003010.GA15481@kroah.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain> <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net> <20050202232909.GA14607@kroah.com> <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 07:07:21PM -0500, Pavel Roskin wrote:
> On Wed, 2 Feb 2005, Greg KH wrote:
> >On Wed, Feb 02, 2005 at 03:23:30PM -0800, Patrick Mochel wrote:
> >>
> >>What is wrong with creating a (GPL'd) abstraction layer that exports
> >>symbols to the proprietary modules?
> >
> >Ick, no!
> >
> >Please consult with a lawyer before trying this.  I know a lot of them
> >consider doing this just as forbidden as marking your module
> >MODULE_LICENSE("GPL"); when it really isn't.
> 
> There will be a GPL'd layer, and it's likely that sysfs interaction will 
> be on the GPL'd side anyway, for purely technical reasons.  But it does 
> feel like circumvention of the limitations set in the kernel.

It is.  And as such, it is not allowed.

> I thought it would be polite to ask the developers to lift those
> limitations, considering that they seem unfair and inconsistent with
> the stated purpose of EXPORT_SYMBOL_GPL.

No, the stated purpose of that marking is to prevent non-GPLd code from
using those symbols.  I don't see how you can state that using sysfs
files in your driver does not make it a "derived work" and force you to
make all of your driver GPL.

I suggest that you consult your company's lawyers for what to do here.

Good luck,

greg k-h
