Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUDZXBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUDZXBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 19:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUDZXBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 19:01:48 -0400
Received: from mail.stw-bonn.de ([131.220.99.37]:24781 "EHLO mail.stw-bonn.de")
	by vger.kernel.org with ESMTP id S261798AbUDZXBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 19:01:47 -0400
Date: Tue, 27 Apr 2004 00:53:40 +0200
From: "E. Oltmanns" <oltmanns@uni-bonn.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Greg KH <greg@kroah.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops during usb usage (2.6.5)
Message-ID: <20040426225340.GA2230@local>
References: <20040423205617.GA1798@local> <408D4187.2040104@tmr.com> <20040426195359.GA29062@kroah.com> <200404270017.34478.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404270017.34478.oliver@neukum.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 12:17:34AM +0200, Oliver Neukum wrote:
> Am Montag, 26. April 2004 21:53 schrieb Greg KH:
> > On Mon, Apr 26, 2004 at 01:06:15PM -0400, Bill Davidsen wrote:
> > > Just in general, if there is anything a non-root user can do to crash
> > > the system, it's probably a kernel bug by definition. It doesn't matter
> > > that's it a stupid thing to do, it might be malicious. And in this case
> > > it might just be user error.
> >
> > But you either have to be root in order to talk to usbfs, or you were
> > root when you gave a user access to the usbfs node.  So either way, a
> > "normal" user can't even do this.
> 
> Greg,
> 
> that's not an answer. It in effect means that usbfs is useless.
Particularly in network environtments the lack of locking facilities
is more than just discomfort even if root has the option of (limitted)
user level access control. But even if just local users were allowed
to use usbfs, double access could easily happen by accident, i.e., I
didn't expect
scanimage -h
to list the availlable scanners which caused the failure of usbfs in
my case. In conclusion I dare say that any effort on the development
of locking facilities for usbfs will be most likely appreciated very much.

Regards,
Elias
