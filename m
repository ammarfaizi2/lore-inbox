Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVHATBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVHATBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVHATBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:01:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261165AbVHATBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:01:22 -0400
Date: Mon, 1 Aug 2005 12:03:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show
Message-Id: <20050801120321.230349c5.akpm@osdl.org>
In-Reply-To: <8551.1122898445@ocs3.ocs.com.au>
References: <20050730022955.6c7dd2e8.akpm@osdl.org>
	<8551.1122898445@ocs3.ocs.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
> On Sat, 30 Jul 2005 02:29:55 -0700,
> Andrew Morton <akpm@osdl.org> wrote:
> >Keith Owens <kaos@sgi.com> wrote:
> >>
> >> 2.6.13-rc4 + kdb, with lots of CONFIG_DEBUG options.  There is an
> >>  intermittent use after free in class_device_attr_show.  Reboot with no
> >>  changes and the problem does not always recur.
> >> ...
> >>  ip is at class_device_attr_show+0x50/0xa0
> >> ...
> >
> >It might help to know which file is being read from here.
> >
> >The below patch will record the name of the most-recently-opened sysfs
> >file.  You can print last_sysfs_file[] in the debugger or add the
> >appropriate printk to the ia64 code?
> 
> No need for a patch.  It is /dev/vcsa2.

You mean /sys/class/vc/vcsa2?

That appears to be using generic code...

Can you please summarise what you curently know about this bug?  What is
being accessed after free in class_device_attr_show()?  class_dev_attr? 
cd?

