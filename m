Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVBGDlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVBGDlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVBGDlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:41:17 -0500
Received: from ozlabs.org ([203.10.76.45]:43660 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261332AbVBGDlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:41:13 -0500
Subject: Re: [PATCH] module-init-tools: generate modules.seriomap
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.de>, Greg KH <greg@kroah.com>
In-Reply-To: <200502060255.30088.dtor_core@ameritech.net>
References: <200502060255.30088.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 14:41:48 +1100
Message-Id: <1107747708.8689.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 02:55 -0500, Dmitry Torokhov wrote:
> Hi Rusty,
> 
> I have converted serio bus to use ID matching and changed serio drivers
> to use MODULE_DEVICE_TABLE. Now that Vojtech pulled the changes into his
> tree it would be nice if official module-init-tools generated the module
> map so that hotplug scripts could automatically load proper drivers.

Sure, applied.  I would appreciated tests, however: you can download the
testsuite from the same place you get module-init-tools.  I don't expect
you to be able to compile for all endian/size combinations, but I can do
that for you.

You should also put the logic into the kernel's scripts/mod/file2alias,
which is where this is supposed to go these days (I haven't removed the
modules.XXX files, since hotplug has enough deployment problems without
me making things worse).

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

