Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbUKDXd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbUKDXd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUKDXd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:33:56 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:63694 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262472AbUKDXdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:33:54 -0500
From: Benno <benjl@cse.unsw.edu.au>
To: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Date: Fri, 5 Nov 2004 10:33:40 +1100
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104233338.GA31392@cse.unsw.edu.au>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031124.19179.gene.heskett@verizon.net> <20041103201322.GA10816@hh.idb.hist.no> <200411031540.03598.gene.heskett@verizon.net> <20041104100749.GA23996@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104100749.GA23996@merlin.emma.line.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 04, 2004 at 11:07:49 +0100, Matthias Andree wrote:
>On Wed, 03 Nov 2004, Gene Heskett wrote:
>
>> >Yes it does - the problem is that not all resources are managed
>> >by processes.  Some allocations are managed by drivers, so a driver
>> >bug can get the device into a unuseable state _and_ tie up the
>> >process(es) that were using the driver at the moment.
>> 
>> This from my viewpoint, is wrong.  The kernel, and only the kernel 
>> should be ultimately responsible for handing out resources, and 
>> reclaiming at its convienience.
>
>Linux's driver model is the way it is. If you want the kernel to clean
>up after a driver has puked, you need something like a microkernel I
>believe, where only a minimal core kernel is a real kernel and where all
>the drivers are actually in user-space, but that's no longer Linux then.

Of course some drivers are already in user-space on Linux. (E.g: X
graphics cards). Work by the Gelato project has added support to the
Linux kernel to allow more complicated drivers (e.g: those requiring
interrupts) to be run outside the kernel on Linux.

http://www.gelato.unsw.edu.au/cgi-bin/viewcvs.cgi/cvs/kernel/usrdrivers/

Cheers,

Benno
