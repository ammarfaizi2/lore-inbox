Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968047AbWLEC71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968047AbWLEC71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 21:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968048AbWLEC70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 21:59:26 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:47570 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968047AbWLEC70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 21:59:26 -0500
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1165286169.6023.1.camel@localhost>
References: <1164205742.13434.4.camel@localhost>
	 <20061122152559.72efd379.akpm@osdl.org> <1165286169.6023.1.camel@localhost>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 03:59:24 +0100
Message-Id: <1165287564.6023.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 03:36 +0100, Kasper Sandberg wrote:
> i know i said i suspected this was another bug, but i have revised my
> suspecisions, and i do believe its in relation to x86 chroot on x86_64
> install, as it has happened with more stuff now, inside the chroot, and
> only inside the chroot, while the same apps dont do it outside chroot.
and by that (so that theres no confusion), i mean that with the x86_64
binaries of the same application dont crash it, but the x86 binaries in
the chroot does :)
> 
> 2.6.19 release is affected too
> 
> On Wed, 2006-11-22 at 15:25 -0800, Andrew Morton wrote:
> > On Wed, 22 Nov 2006 15:29:02 +0100
> > Kasper Sandberg <lkml@metanurb.dk> wrote:
> > 
> > > it appears some sort of bug has gotten into .19, in regards to x86
> > > emulation on x86_64.
> > > 
> > > i have only tested with >=rc5, thw folling, as an example, appears in
> > > dmesg:
> > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > arg(00221000) on /home/redeeman
> > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
> > 
> > Try
> > 
> > 	echo 0 > /proc/sys/kernel/compat-log
> > 
> > I don't _think_ we did anything to change the logging in there.  Which kernel
> > version were you using previously (the one which didn't do this)?
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

