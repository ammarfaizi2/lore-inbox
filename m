Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbTJPIYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTJPIYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:24:18 -0400
Received: from ltgp.iram.es ([150.214.224.138]:12417 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262768AbTJPIYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:24:17 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 16 Oct 2003 10:16:11 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031016081611.GA14949@iram.es>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay> <20031014155638.7db76874.cliffw@osdl.org> <20031015124842.GE20846@lug-owl.de> <20031015131015.GR16158@holomorphy.com> <20031015181658.GA9652@iram.es> <20031016051951.GP20846@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016051951.GP20846@lug-owl.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 07:19:51AM +0200, Jan-Benedict Glaw wrote:
> On Wed, 2003-10-15 20:16:58 +0200, Gabriel Paubert <paubert@iram.es>
> wrote in message <20031015181658.GA9652@iram.es>:
> > On Wed, Oct 15, 2003 at 06:10:15AM -0700, William Lee Irwin III wrote:
> > > On Tue, 2003-10-14 15:56:38 -0700, cliff white <cliffw@osdl.org>
> > > Can you quantify the performance impact of cmov emulation (or whatever
> > > it is)? I have a vague notion it could be hard given the daunting task
> > > of switching userspace around to verify it.
> > The other problem of the 386 is that it has a fundamental MMU flaw:
> > no write protection on kernel mode accesses to user space, which makes 
> > put_user() intrinsically racy on a 386 and way more bloated when it is
> > inlined (access_ok has to call a function which searches the VMA tree).
> 
> However, this problem exists since the very first hour. Linux once
> really ran quite well on those machines...

Yes, but VM sharing between threads was rather infrequent back then
and you need shared VM to create the race.

> 
> I've rebooted my P-Classic router last night. Maybe I can see (in two
> weeks or in a month or the like...) why it slows down, even with 32MB
> RAM...

It might be related to the size-4096 memory leak others are reporting 
right now. I don't know, but it's not such a far-fetched hypothesis
either.

	Gabriel
