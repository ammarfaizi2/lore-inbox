Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264971AbUFUDxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUFUDxY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUFUDxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:53:23 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:6874 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264971AbUFUDxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:53:05 -0400
Date: Sun, 20 Jun 2004 23:55:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-bk way too fast
In-Reply-To: <Pine.LNX.4.58.0406202348040.3273@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0406202354540.3273@montezuma.fsmlabs.com>
References: <40D64DF7.5040601@pobox.com> <40D657B7.8040807@pobox.com>
 <Pine.LNX.4.58.0406202348040.3273@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Zwane Mwaikambo wrote:

> On Sun, 20 Jun 2004, Jeff Garzik wrote:
>
> > Jeff Garzik wrote:
> > >
> > > Something is definitely screwy with the latest -bk.  I updated from a
> > > kernel ~1 week ago, and all timer-related stuff is moving at a vastly
> > > increased rate.  My guess is twice as fast.  Most annoying is the system
> > > clock advances at twice normal rate, and keyboard repeat is so sensitive
> > > I am spending quite a bit of time typing this message, what with having
> > > to delettte (<== example) extra characters.  Double-clicking is also
> > > broken :(
> >
> > Looks like disabling CONFIG_ACPI fixes things.  Narrowing down cset now...
>
> My suspect is;
>
> ChangeSet 1.1731 2004/06/18 01:56:40 len.brown@intel.com
>   Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
>   into intel.com:/home/lenb/bk/linux-acpi-test-2.6.7

Make that;

ChangeSet 1.1608.11.12 2004/06/18 00:18:19 len.brown@intel.com
  [ACPI] handle SCI override to nth IOAPIC
  http://bugzilla.kernel.org/show_bug.cgi?id=2835
arch/i386/kernel/mpparse.c 1.72.1.1 2004/06/17 20:18:02 len.brown@intel.com
  handle SCI override to nth IOAPIC
