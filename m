Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTI0EBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTI0EBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:01:15 -0400
Received: from rth.ninka.net ([216.101.162.244]:44978 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262114AbTI0EBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:01:13 -0400
Date: Fri, 26 Sep 2003 21:00:34 -0700
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: joe.korty@ccur.com, jdeas@jadsystems.com, linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
Message-Id: <20030926210034.3a1b4de7.davem@redhat.com>
In-Reply-To: <1064623209.631.26.camel@gaston>
References: <1064609623.16160.11.camel@ArchiveLinux>
	<20030926211740.GA27352@tsunami.ccur.com>
	<1064623209.631.26.camel@gaston>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003 02:40:10 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> mmap of /proc/bus/pci is a standard thing in 2.4 already and so in 2.6
> as well, though not all archs may implement it..

If someone is looking for something to do, it would be incredibly
value to make it so that all arches support this, and in particular
get right the case of mmap()'ing the PCI host bridge.

If this were done, the PCI domain code in xfree86 could be enabled
for all Linux platforms, not just the ones that have this implemented
properly.
