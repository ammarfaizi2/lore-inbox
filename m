Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUIEDBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUIEDBt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 23:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUIEDBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 23:01:49 -0400
Received: from peabody.ximian.com ([130.57.169.10]:41435 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266143AbUIEDBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 23:01:41 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040905021830.GA534@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com>  <20040905021830.GA534@vrfy.org>
Content-Type: text/plain
Date: Sat, 04 Sep 2004 23:01:41 -0400
Message-Id: <1094353301.2591.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 04:18 +0200, Kay Sievers wrote:

> If we add this to the kobject_hotplug function, how do we prevent the
> execution of /sbin/hotplug for ksets that have positive hotplug filters?

Ah, another good point.

> So I've created a new function for now:
>   int kobj_notify(const char *signal, struct kobject *kobj, struct attribute *attr)
> which can be used from the subsystems. This function is also called for
> the normal /sbin/hotplug event. (The subsystems may provide a additional
> environment for the /sbin/hotplug events, this is ignored by now.)

This is basically the last patch I posted, with the removel of "enum
kevent" and the addition of struct attribute *attr".

Which is exactly what I want. ;-)

Best,

	Robert Love


