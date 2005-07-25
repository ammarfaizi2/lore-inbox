Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVGYWCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVGYWCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVGYWCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:02:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261200AbVGYWCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:02:18 -0400
Date: Mon, 25 Jul 2005 15:01:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 udev/hotplug use memory after free
Message-Id: <20050725150119.1c2714f3.akpm@osdl.org>
In-Reply-To: <7304.1121837704@kao2.melbourne.sgi.com>
References: <7304.1121837704@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
> 2.6.13-rc3 + kdb (which does not touch udev/hotplug) on IA64 (Altix).
>  gcc version 3.3.3 (SuSE Linux).  Compiled with DEBUG_SLAB,
>  DEBUG_PREEMPT, DEBUG_SPINLOCK, DEBUG_SPINLOCK_SLEEP, DEBUG_KOBJECT.
> 
>  There is a use after free somewhere above class_device_attr_show.

Can we obtain a backtrace for this one, Keith?  The function itself is
pretty innocuous and is used by many callers.  I'd be suspectng a bug in
the caller.
