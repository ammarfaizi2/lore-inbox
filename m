Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUGFNnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUGFNnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 09:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUGFNnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 09:43:18 -0400
Received: from web81304.mail.yahoo.com ([206.190.37.79]:55668 "HELO
	web81304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263881AbUGFNm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 09:42:57 -0400
Message-ID: <20040706134256.28900.qmail@web81304.mail.yahoo.com>
Date: Tue, 6 Jul 2004 06:42:56 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.7-mm6
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-
> mm6/
> > - Added the DVD-RW/CD-RW packet writing patches.  These need more work.
> > - The USB update seems deadlocky.  I fixed one bug but it still causes
> my
> >   ia64 test box to lock up on boot.  If it goes bad, please revert
> >   usb-locking-fix.patch and then revert bk-usb.patch.  Retest and send a
> report
> >   to linux-kernel and linux-usb-devel@lists.sourceforge.net.
> 
> Uneventful on alpha, needed a make rpm compilefix Andi's got queued for
> the next merge on x86-64 and otherwise uneventful there.
> 
> OTOH, various things made sparc64 a living Hell that took about 9
> hours of solid compile/boot/crash drudgery to carry out bisection
> search on to find the offending patches.
> 
> First, I had to back out bk-input because it has a sysfsification patch
> that deadlocks sunzilog.c at boot.

Do you know where exactly it was deadlocked? As fas as sunzilog goes
the only change was that instead of embedding serio structure inside
uart_sunzilog_port it is now accessed through a pointer. The rest of
the changes are in serio core and should not depend on type of serio
port involved, locking rules have not been changed either...

Any additional info will be appreciated...

--
Dmitry
 

