Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbTDNTkD (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTDNTkD (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:40:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62730 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263725AbTDNTkB convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:40:01 -0400
Date: Mon, 14 Apr 2003 12:51:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304142103290.5042-100000@serv>
Message-ID: <Pine.LNX.4.44.0304141249130.32035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h3EJpKa14113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Apr 2003, Roman Zippel wrote:
> 
> > But at the same time, for backwards compatibility clearly they have to
> > show up in the _old_ places too. Which really implies that there needs to
> > be a mapping function for the old numbers into the proper block device
> > queues etc, so that people can still use the old /dev nodes when they
> > upgrade their kernel.
> 
> Why should the kernel care about this?

Because a kernel that cannot be used with old filesystems is a _useless_ 
kernel as far as I'm concerned.

Backwards compatibility is _important_. It's HUGELY important. It's just
possibly more important than anything else the kernel ever can do.

And new kernels need to be able to seamlessly boot into a disk-image that 
may still need to be used from an old kernel. Without any magic going on.

We can discontinue the old IDE/SCSI majors one or two stable releases 
_after_ we've switched over to a global "disk major". In other words, 
that's about five years down the line after you shouldnä't have to care 
any more.

		Linus

