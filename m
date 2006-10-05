Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWJEHGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWJEHGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWJEHGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:06:49 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:12180 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751515AbWJEHGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:06:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: error to be returned while suspended
Date: Thu, 5 Oct 2006 09:07:26 +0200
User-Agent: KMail/1.8
References: <200610031323.00547.oliver@neukum.org> <200610041834.57639.oliver@neukum.org> <20061004224448.GL8440@elf.ucw.cz>
In-Reply-To: <20061004224448.GL8440@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050907.27035.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2006 00:44 schrieben Sie:
> Hi!
> 
> > > > which error should a character device return if a read/write cannot be
> > > > serviced because the device is suspended? Shouldn't there be an error
> > > > code specific to that?
> > > 
> > > If you are talking system suspend, then userspace should not run while
> > > devices are suspended.
> > > 
> > > If you are talking runtime suspend, you should probably just wake the
> > > device up on first access.
> > 
> > Do you really think a device driver should override an explicitely
> > selected power state?
> 
> (So we are talking runtime suspend?)

Yes. Otherwise the patch would have been ready two days ago.
But if I am implenting this, I'll do a full implementation.

> No, I do not know what the right interface is. I started to suspect
> that drivers should suspend/resume devices automatically, without
> userland help. Maybe having autosuspend_timeout in sysfs is enough.

If you do this at kernel level, you'll screw up any demon implementing
a power policy to stay within the budget.

	Regards
		Oliver
