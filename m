Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUEFOGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUEFOGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUEFOGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:06:44 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:64522 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S261798AbUEFOFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:05:32 -0400
To: Oliver Neukum <oliver@neukum.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
	<20040504200147.GA26579@kroah.com> <s5ghduvdg1u.fsf@patl=users.sf.net>
	<200405060033.49380.oliver@neukum.org>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gekpxslti.fsf@patl=users.sf.net>
Date: 06 May 2004 10:05:32 -0400
In-Reply-To: <200405060033.49380.oliver@neukum.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oliver@neukum.org> writes:

> The set of devices connected to the machine is not static. Waiting
> until all hardware is ready is very hard to even define.

It is very easy to define for 99.999% of all keyboards, which start
off connected and stay connected.

This should be simple.  I want to load a driver at boot time and wait
until it either binds to something or fails to do so.  If the user is
adding or removing hardware while the module is loading, I simply do
not care what the system does.  But if the hardware is not changing, I
care a great deal...  And the latter case is perfectly well-defined.

> > be glad to use any other mechanism to achieve the same effect; I just
> > have not seen one yet.
> 
> Issue ioctl() USBDEVFS_CONNECT through usbfs. It does a synchronous
> probe for a specific device.

I suppose this would solve my USB keyboard problem.  But a) it seems
very complex for such a simple need; and b) it does not work for
non-USB devices, which are also causing me grief.

 - Pat
