Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTDKWTL (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbTDKWTL (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:19:11 -0400
Received: from hockin.org ([66.35.79.110]:30884 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261845AbTDKWTK (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:19:10 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200304112219.h3BMJMG11078@www.hockin.org>
Subject: Re: [ANNOUNCE] udev 0.1 release
To: akpm@digeo.com (Andrew Morton)
Date: Fri, 11 Apr 2003 15:19:22 -0700 (PDT)
Cc: sdake@mvista.com (Steven Dake), kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com, greg@kroah.com
In-Reply-To: <20030411150933.43fd9a84.akpm@digeo.com> from "Andrew Morton" at Apr 11, 2003 03:09:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A much better solution could be had by select()ing on a filehandle 
> > indicating when a new hotswap event is ready to be processed.  No races, 
> > no security issues, no performance issues.
> 
> I must say that I've always felt this to be a better approach than the
> /sbin/hotplug callout.

I've always liked this approach, too - if you look at acpid, it is designed
to be gereically useful for this model of kernel->userland notification.

With minor mods, it could become 'eventd' and handle ACPI, hotplug, netlink,
and any other style kernel->user notice.

