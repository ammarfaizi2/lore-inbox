Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTKDVkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTKDVkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 16:40:20 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:19945 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262570AbTKDVkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 16:40:16 -0500
Date: Tue, 4 Nov 2003 16:39:59 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Venezia <pvenezia@jpj.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
Message-ID: <20031104213959.GD30612@ti19.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Linus Torvalds <torvalds@osdl.org>, Paul Venezia <pvenezia@jpj.net>,
	linux-kernel@vger.kernel.org
References: <20031104202037.GB30612@ti19.telemetry-investments.com> <Pine.LNX.4.44.0311041227180.20373-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311041227180.20373-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 12:30:23PM -0800, Linus Torvalds wrote:
> But there really should be zero contention on the stdio data structures, 
> so the locking would have to be _seriously_ broken to make that kind o 
> fdifference (not necessarily buggy, but seriously badly implemented). 
> 
> A non-contended lock should be at most one locked instruction if well 
> done, both on LinuxThreads and NPTL.

The results that I just posted are also for Red Hat 9, kernel 2.4.20-20.9.

rugolsky@ti31: getconf GNU_LIBPTHREAD_VERSION
NPTL 0.34

Ulrich's release notes for nptl-0.57 says:

   The changes are numerous and most of them were made by Jakub:

   ...

   ~ better stdio locking

I don't have my laptop running Fedora handy, but that's the next thing
to test.

Regards,

	Bill Rugolsky
