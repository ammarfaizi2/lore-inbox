Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031223AbWFOTqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031223AbWFOTqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031224AbWFOTqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:46:36 -0400
Received: from xenotime.net ([66.160.160.81]:37540 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1031223AbWFOTqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:46:35 -0400
Date: Thu, 15 Jun 2006 12:49:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.20 build failure.
Message-Id: <20060615124922.56e3b76b.rdunlap@xenotime.net>
In-Reply-To: <20060615184635.GA6370@aehallh.com>
References: <20060615184635.GA6370@aehallh.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006 14:46:35 -0400 Zephaniah E. Hull wrote:

> I got this while trying to prune the kernel down to fit into a zImage
> for testing (have a box that's being stubborn about getting to even the
> 'Uncompressing Linux...' message).
> 
>   LD      vmlinux
> lib/lib.a(kobject_uevent.o): In function
> `kobject_uevent':kobject_uevent.c:(.text+0x25b): undefined reference to
> `uevent_seqnum'
> :kobject_uevent.c:(.text+0x261): undefined reference to `uevent_seqnum'
> :kobject_uevent.c:(.text+0x26d): undefined reference to `uevent_seqnum'
> :kobject_uevent.c:(.text+0x273): undefined reference to `uevent_seqnum'
> :kobject_uevent.c:(.text+0x3bf): undefined reference to `uevent_helper'
> :kobject_uevent.c:(.text+0x3ce): undefined reference to `uevent_helper'
> :kobject_uevent.c:(.text+0x3ed): undefined reference to `uevent_helper'
> make[1]: *** [vmlinux] Error 1
> 
> 
> The .config is attached.

There is a fix with the bugzilla for this bug.
See http://bugzilla.kernel.org/show_bug.cgi?id=6306
and the patch: http://bugzilla.kernel.org/attachment.cgi?id=7754&action=view

2.6.16.20 is 10 days old, probably time for a new one with fixes. :)

---
~Randy
