Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVBPV7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVBPV7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVBPV7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:59:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262096AbVBPV7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:59:24 -0500
Date: Wed, 16 Feb 2005 13:59:10 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: chriswhite@gentoo.org
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel Driver Automation
Message-ID: <20050216135910.1873a672@localhost.localdomain>
In-Reply-To: <mailman.1108494546.30588.linux-kernel2news@redhat.com>
References: <mailman.1108494546.30588.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005 04:05:47 +0900, Chris White <chriswhite@gentoo.org> wrote:

> Ironically, if the network card driver is not working, there's no way to
> google around for information on what modules to compile in for various
> drivers. [...]

I always google for the PCI IDs which lspci -n shows.

> The basic idea would be to have a userspace program that would be run
> before the kernel compile process and check the device identification
> string (using /proc?) and match it up against the correct module. [...]

We already do have such a program, it's called /sbin/hotplug. The missing
piece for your scheme, however, is that the maps which govern hotplug are
generated from C files. Therefore, the code is patched to add new IDs.
AFAIK, Greg Kroah worked on a more configurable way to match drivers with
devices within the hotplug framework. You might want to talk to Greg
about this.

By the way, Greg is a Gentoo developer as well, but pleas keep this to
a common forum. I'm sure folks from other distros are be interested.

Jaa ne,
-- Pete
