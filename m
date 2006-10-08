Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWJHNXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWJHNXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWJHNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:23:30 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:50909 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751143AbWJHNX3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:23:29 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sun, 8 Oct 2006 15:24:09 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071916.27315.oliver@neukum.org> <200610071703.24599.david-b@pacbell.net>
In-Reply-To: <200610071703.24599.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610081524.09946.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Oktober 2006 02:03 schrieb David Brownell:
> > The power management functions without 
> > timeout are also exported. For other power control features like
> > cpu frequency considerable effort has been made to export them to
> > user space.
> 
> Yes, and many of us use the much lighter weight kernel based control
> models by preference.   Why waste hundreds of Kbytes of userspace for
> a daemon when a few hundred bytes of kernel code can implement a
> better and more reactive kernel policy for cpufreq?

That's an important aspect. How about implementing autosuspend
first and keeping the sysfs-based suspension for now? If autosuspend
is done, we have something to compare too. If a different solution
emerges to be advantagous under some conditions we can talk about
the interface later.

	Regards
		Oliver
