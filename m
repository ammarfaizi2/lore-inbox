Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWDZVES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWDZVES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWDZVES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:04:18 -0400
Received: from xenotime.net ([66.160.160.81]:53454 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932318AbWDZVER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:04:17 -0400
Date: Wed, 26 Apr 2006 14:06:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drbd-0.7.18 doesn't compile under 2.617-rc2 because
 SLAB_NO_REAP is missing
Message-Id: <20060426140643.d5775d55.rdunlap@xenotime.net>
In-Reply-To: <a0623092dc075772b201c@[129.98.90.227]>
References: <a0623092dc075772b201c@[129.98.90.227]>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 15:16:33 -0400 Maurice Volaski wrote:

> Being forwarded here from the drbd mailing list in case SLAB_NO_REAP 
> got removed from the kernel source inadvertently....

It's no longer used in the kernel tree.  Here's the patch
that removed it:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ac2b898ca6fb06196a26869c23b66afe7944e52e

> >
> >It was previously reported (twice) that drbd-0.7.17 didn't compile 
> >under the initial releases of 2.6.17. Neither does 0.7.18.
> >
> >/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c: In 
> >function `drbd_create_mempools':
> >/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c:1547: 
> >error: `SLAB_NO_REAP' undeclared (first use in this function)
> >/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c:1547: 
> >error: (Each undeclared identifier is reported only once
> >/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c:1547: 
> >error: for each function it appears in.)
> >make[3]: *** 
> >[/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.o] 
> >Error 1
> >make[2]: *** 
> >[_module_/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd] Error 2
> >--

---
~Randy
