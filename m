Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUFJRzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUFJRzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 13:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUFJRzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 13:55:40 -0400
Received: from 80-218-63-25.dclient.hispeed.ch ([80.218.63.25]:14818 "EHLO
	xbox.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id S262170AbUFJRzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 13:55:39 -0400
Subject: Re: Finding user/kernel pointer bugs [no html]
From: Thomas Sailer <sailer@scs.ch>
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       David Brownell <david-b@pacbell.net>,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040610165821.GB32577@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
	 <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
	 <20040610165821.GB32577@kroah.com>
Content-Type: text/plain
Organization: Supercomputing Systems AG
Message-Id: <1086890076.3401.2.camel@gamecube.scs.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Jun 2004 19:54:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-10 at 18:58, Greg KH wrote:

> > 	b) WTF is usb doing messing with it directly?
> > Note that drivers/usb/core/{devio,inode}.c are the only users of that animal
> > outside of arch/*.  Looks fishy...
> 
> I really don't know.  I think David added that code.  David, any ideas?

The idea was to tell the user which of his queued transfers completed.
si_addr seemed usable for this. as->userurb is the address of the
request structure in the user's memory.

Tom


