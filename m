Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUD0JFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUD0JFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 05:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbUD0JFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 05:05:22 -0400
Received: from mail1.kontent.de ([81.88.34.36]:30147 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263928AbUD0JFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 05:05:06 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: Kernel Oops during usb usage (2.6.5)
Date: Tue, 27 Apr 2004 11:04:59 +0200
User-Agent: KMail/1.5.1
Cc: Bill Davidsen <davidsen@tmr.com>, "E. Oltmanns" <oltmanns@uni-bonn.de>,
       linux-kernel@vger.kernel.org
References: <20040423205617.GA1798@local> <200404270017.34478.oliver@neukum.org> <20040426223101.GA9258@kroah.com>
In-Reply-To: <20040426223101.GA9258@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404271104.59934.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 27. April 2004 00:31 schrieb Greg KH:
> On Tue, Apr 27, 2004 at 12:17:34AM +0200, Oliver Neukum wrote:
> > Am Montag, 26. April 2004 21:53 schrieb Greg KH:
> > > On Mon, Apr 26, 2004 at 01:06:15PM -0400, Bill Davidsen wrote:
> > > > Just in general, if there is anything a non-root user can do to crash
> > > > the system, it's probably a kernel bug by definition. It doesn't
> > > > matter that's it a stupid thing to do, it might be malicious. And in
> > > > this case it might just be user error.
> > >
> > > But you either have to be root in order to talk to usbfs, or you were
> > > root when you gave a user access to the usbfs node.  So either way, a
> > > "normal" user can't even do this.
> >
> > Greg,
> >
> > that's not an answer. It in effect means that usbfs is useless.
>
> Heh.  So the correct answer is:
> 	- don't do that.  Talking to the same device through usbfs at
> 	  the same time by multiple programs is cause for lots of bad
> 	  things to happen to your device, and might possibly cause it
> 	  to hang.  If you want to allow a user to access a device
> 	  through usbfs, make sure you trust them.
>
> Better?  :)

But that's not the issue, he got an oops.
No, don't do that means: Reserve usbfs to root.
Crashing a device which access is given to is maybe acceptable. Anything
more clearly is not.

	Regards
		Oliver

