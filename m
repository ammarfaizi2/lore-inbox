Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUBIMCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUBIMCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:02:04 -0500
Received: from [217.157.19.70] ([217.157.19.70]:43279 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S264974AbUBIMB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:01:59 -0500
Date: Mon, 9 Feb 2004 12:01:55 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: Re: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.)
 BIOS RAID development
In-Reply-To: <1076320246.4444.0.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.40.0402091155040.8715-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Arjan van de Ven wrote:

> > The reason I insist on autodetection is that I think it's important that if
> > the BIOS will reckognise the drive without additional intervention, so will
> > Linux. This will make the entry route for newbies much simpler.
>
> do you call running devicemapper tools from the initrd autodetection ?

Probably not. I am working with several ways of doing it, and that's why I
wanted to have a discussion about this.

Ideally I'd want something like the MD autodetect code, so that the whole
thing can be set up by the kernel at boot-time if the necessary drivers
are compiled in (by reading the Medley superblock the same way it's done
for 0xfe partitions). And if the drivers are modules, then use the drive
mapper tools from userspace to set it up.

This would be the most flexible solution, since it'd allow you to boot
without an initrd if you wanted that, or to use the initrd and map the
drives manually if you preferred that solution.

Having autodetection at kernel level would make it possible to boot from a
kernel on a floppy disk without initrd support, and in general make a
system easier to set up.

But the reason I wanted this discussion is to figure out the best way to
go about it, and if there are some good arguments against autodetecting in
the kernel I'll listen to them.

// Thomas

