Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUFVOsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUFVOsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFVOrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:47:13 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36591 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264206AbUFVOiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:38:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.17486.81041.111276@alkaid.it.uu.se>
Date: Tue, 22 Jun 2004 16:38:06 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
In-Reply-To: <20040622022023.1942fd82.akpm@osdl.org>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
	<20040622085901.GA31971@infradead.org>
	<20040622020417.0ec87564.akpm@osdl.org>
	<20040622091219.GA32146@infradead.org>
	<20040622021441.4f6aa13c.akpm@osdl.org>
	<20040622091850.GA32160@infradead.org>
	<20040622022023.1942fd82.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Christoph Hellwig <hch@infradead.org> wrote:
 > >
 > > On Tue, Jun 22, 2004 at 02:14:41AM -0700, Andrew Morton wrote:
 > > > > Let's ressurect that code instead of doing the syscall approach.
 > > > 
 > > > This appears to have come out of the blue.  Please explain why you think
 > > > this change is needed.
 > > 
 > > Just read through all the old perfctr threads.  This was discussed multiple
 > > times.
 > 
 > Well it didn't register with me and either it didn't register with Mike, or
 > he rejected the notion.
 > 
 > Please restate the case.

Swiching to open() on /proc/<pid>/<tid>/perfctr followed by ioctl()s
would be easy to implement. But people @ LKML are sometimes violently
opposed to ioctl()s, that's why the switch to syscalls happended.

One concern is that there doesn't appear to be a user-visible shortcut
to "your own" /proc/<pid>/<tid>/ like there was when /proc/self still
had some useful meaning. This is merely annoying, not a show-stopper.
