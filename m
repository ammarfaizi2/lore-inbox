Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUJ0JBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUJ0JBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbUJ0JBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:01:24 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:5630 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262337AbUJ0JAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:00:18 -0400
Date: Wed, 27 Oct 2004 10:58:42 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with module parameters and sysfs
Message-ID: <20041027085842.GA7510@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Rusty Russell <rusty@rustcorp.com.au>,
	LKML <linux-kernel@vger.kernel.org>
References: <200410270143.54852.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410270143.54852.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 01:43:54AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> It seems that the following patch
> 
> http://linux.bkbits.net:8080/linux-2.5/diffs/kernel/params.c%401.12?nav=index.html|ChangeSet@-3d|cset@1.2142
> 
> broke module parameters in sysfs for the case when driver is built
> as a module:
> 
> [root@core dtor]# ls -la /sys/module/i8042/
> total 0
> drwxr-xr-x    3 root     root            0 Oct 26 19:20 .
> drwxr-xr-x   54 root     root            0 Oct 27 00:28 ..
> drwxr-xr-x    2 root     root            0 Oct 26 19:20 parameters
> 
> [root@core dtor]# ls -la /sys/module/psmouse/
> total 0
> drwxr-xr-x    3 root     root            0 Oct 27 00:21 .
> drwxr-xr-x   54 root     root            0 Oct 27 00:28 ..
> -r--r--r--    1 root     root         4096 Oct 27 00:21 refcnt
> drwxr-xr-x    2 root     root            0 Oct 27 00:21 sections
> 
> psmouse is built as a module while i8042 is compiled in.

All module_params I can see in psmouse have permission "0", so they don't
need to be exported in sysfs. Or am I missing something here?

Thanks,
	Dominik
