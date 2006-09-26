Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWIZKVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWIZKVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWIZKVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:21:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:60347 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751086AbWIZKVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:21:16 -0400
X-Authenticated: #14349625
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.18
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060926053728.GA8970@kroah.com>
References: <20060926053728.GA8970@kroah.com>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 12:34:05 +0000
Message-Id: <1159274045.6433.31.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 22:37 -0700, Greg KH wrote:
> Here are a bunch of driver core and sysfs patches and fixes for 2.6.18.

Hi,

Just as an fyi, these patches cause a ~regression on my P4/HT box.

Suspend stopped here working after 2.6.17.  I haven't dug into why, but
since then, I get a message "Class driver suspend failed for cpu0", and
the suspend fails, but everything works fine afterward.  If I ignore the
return of drv->suspend(), the box will suspend and resume just fine,
both with this patch set and without.  (which is what I've been doing
while waiting for it to fix itself or for my round toit to turn up)

In the fail case _with_ this set though, all is not well after a failed
suspend.  The box isn't locked up, but it's ding-dong dead.  The GUI
freezes, but I can switch to command line.  I get to a login prompt, but
as I try to login, that VT is toast.  I tried a SysRq-T to see what
everybody's up to, but after the failure, we apparently never get as far
as restoring serial.  SysRq-B works.  SysRq-O don't.

It seems to be just me, (and I apparently don't care very much), but I
figured I should let you know about it.

	Cheers,

	-Mike

