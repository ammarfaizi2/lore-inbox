Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbUKLQb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbUKLQb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUKLQb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:31:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:18648 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262564AbUKLQal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:30:41 -0500
Subject: Re: errors during umount make SysRq fail
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041111190428.GA997@elf.ucw.cz>
References: <419101BE.1070400@gmx.net>  <20041111190428.GA997@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100273236.25799.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 12 Nov 2004 15:27:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-11 at 19:04, Pavel Machek wrote:
> Hi!
> 
> > having removed an USB disk while umount for it was still running (yes,
> > that was stupid) I noticed that umount for this device hangs forever in
> > D state. That would be ok (consequences for user error), however
> 
> Actually, I do not think that is okay. USB disk removed while you are
> unmounted it is quite simple case of disk error. umount should handle
> it.

Nice theory but 2.6.9 has refcount errors in the eh thread and some
other problems that mean this doesn't happen. It ought to be ok in 10rc1
providing all the patches are merged now

