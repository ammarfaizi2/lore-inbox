Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVDFBVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVDFBVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVDFBVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:21:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39906 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262046AbVDFBVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:21:30 -0400
Subject: Re: [patch] inotify for 2.6.11
From: Robert Love <rml@novell.com>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.04.06.00.53.44.705260@intel.com>
References: <3EqlI-2DI-59@gated-at.bofh.it> <3PRs6-89U-15@gated-at.bofh.it>
	 <3PYWC-636-7@gated-at.bofh.it> <3Q0F6-7Ar-37@gated-at.bofh.it>
	 <3Q4z0-2tA-15@gated-at.bofh.it>  <pan.2005.04.06.00.53.44.705260@intel.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 21:21:23 -0400
Message-Id: <1112750483.13601.10.camel@phantasy.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 17:53 -0700, Rusty Lynch wrote:

> From just a casual look, it seems like this could be used to monitor the
> comings and goings of processes by monitoring /proc.  Unfortunately
> inotify doesn't seem to be getting all the events on the proc filesystem
> like it does on a real filesystem because I am not seeing new events every
> time a new process is added or removed.  The same is true if you attempt
> to monitor something like /sys/bus/usb/devices/ and add/remove a usb
> device.
> 
> On a side note, it's still rather interesting to monitor /proc and watch
> all the traffic.

Yah, I agree.  I looked into doing this awhile back, when I noticed
inotify did not generate events for /proc.  We just need to add calls to
the fsnotify hooks to the proc_create() and proc_delete_foo() stuff.

The interfaces are capable, e.g. we can add support at anytime, even
after inotify is merged.  I'd be for it.

	Robert Love


