Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTIKCoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTIKCnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:43:02 -0400
Received: from dp.samba.org ([66.70.73.150]:15788 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264396AbTIKCmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:42:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module 
In-reply-to: Your message of "Wed, 10 Sep 2003 17:04:29 MST."
             <20030911000429.GF1461@matchmail.com> 
Date: Thu, 11 Sep 2003 12:10:22 +1000
Message-Id: <20030911024252.C69A12C0C7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030911000429.GF1461@matchmail.com> you write:
> On Wed, Sep 10, 2003 at 04:45:38PM -0700, Greg KH wrote:
> > To quote from include/linux/moduleparam.h:
> > /* This is the fundamental function for registering boot/module
> >    parameters.  perm sets the visibility in driverfs: 000 means it's
> >    not there, read bits mean it's readable, write bits mean it's
> >    writable. */
> 
> Any chance to make it always visible and read-only by default with the
> option of making it writable?

Nope.  The author specifies exactly what they want, no default.  It's
just safer this way: see RMK's concerns about what would happen if we
did it to unsuspecting module authors... 

See include/linux/moduleparam.h, especially the module_param() macro.

> Any chance the parameter defaults (if they're not hard coded...) could be
> exposed even if they're not given to the module on the command line?  (wish
> list...)

They should be there.  It would be nice to have some way of telling
which ones were modified, so that a userspace util could save just
those ones on shutdown, for example.  I can't think of an obvious way
of doing this though (mtime > epoch maybe?).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
