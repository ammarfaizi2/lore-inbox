Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268466AbUHLAz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268466AbUHLAz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUHLAxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:53:22 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:59028 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S268242AbUHLAIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:08:37 -0400
Subject: Re: Allow userspace do something special on overtemp
From: Dax Kelson <dax@gurulabs.com>
To: Pavel Machek <pavel@suse.cz>
Cc: trenn@suse.de, seife@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <20040811085326.GA11765@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092269309.3948.57.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 18:08:30 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 02:53, Pavel Machek wrote:
> Hi!
> 
> This patch cleans up thermal.c a bit, and adds possibility to react to
> critical overtemp: it tries to call /sbin/overtemp, and only if that
> fails calls /sbin/poweroff.
> 
> Could it be applied?
> 								Pavel

Why invent Yet-Another-Call-To-Userland-Interface when either
hotplug/dbus, netlink or an ACPI event will do?

The argument "well what if hotplug of acpid don't know what to do" is,
IMO, bogus since:

* Obviously systems today are functioning 
* Hardware will poweroff off on overheat anyway (not graceful, but will
save hardware components)
* Teaching hotplug/apcid isn't hard
* Policy should be kept out of the kernel if at all possible

Dax

