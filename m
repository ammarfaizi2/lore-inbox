Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVHWPGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVHWPGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHWPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:06:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3983 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932173AbVHWPF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:05:59 -0400
Subject: Re: rc6 keeps hanging and blanking displays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
In-Reply-To: <Pine.LNX.4.58.0508221628140.3317@g5.osdl.org>
References: <20050815221109.GA21279@aitel.hist.no>
	 <21d7e99705081516241197164a@mail.gmail.com>
	 <20050816165242.GA10024@aitel.hist.no>
	 <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
	 <20050816211424.GA14367@aitel.hist.no>
	 <21d7e99705081616504d28cca5@mail.gmail.com>
	 <43031A12.8020301@aitel.hist.no>
	 <21d7e997050817040523a1bf46@mail.gmail.com>
	 <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>
	 <20050822214453.GA31266@aitel.hist.no>
	 <21d7e9970508221607bb74cc7@mail.gmail.com>
	 <Pine.LNX.4.58.0508221628140.3317@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 Aug 2005 16:33:41 +0100
Message-Id: <1124811221.27585.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-22 at 16:40 -0700, Linus Torvalds wrote:
> That may be the problem with MGA - I think some gfx cards used the same
> decoder for ROM and for the video RAM aperture, so that you were supposed

MGA requires the ROM can be mapped temporarily in order to read the data
tables. X itself solves this by mapping the ROM over the RAM addresses
assigned by the OS then mapping the RAM back after finishing with the
ROM. Its a fairly standard video card trick.

What X does in the presence of kernel support it recognizes I'm not
however sure.

Alan

