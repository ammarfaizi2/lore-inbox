Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWLAI4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWLAI4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 03:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWLAI4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 03:56:23 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:1473 "EHLO jdi.jdi-ict.nl")
	by vger.kernel.org with ESMTP id S1030391AbWLAI4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 03:56:22 -0500
Date: Fri, 1 Dec 2006 09:56:06 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <20061130212248.1b49bd32.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <20061130212248.1b49bd32.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Fri, 01 Dec 2006 09:56:06 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

> > I've got a machine which occasionally locks up. I can still sysrq it from 
> > a serial console, so it's not entirely dead.
> > 
> > A sysrq-t learns me that it's got a large number of httpd processes stuck 
> > in D state :
> 
> There are known deadlocks in generic_file_write() in kernels up to and
> including 2.6.17.  Pagefaults are involved and I'd need to see the entire
> sysrq-T output to determine if you're hitting that bug.

It's rather large, but for those who want to look at it : 
http://www.jdi-ict.nl/plain/serial-28112006.txt

There is also a dump from a day later, but halfway the Areca controller 
decided to kick out the array, on which a lot of unwritten data needed to 
be written :)

That dump is at http://www.jdi-ict.nl/plain/serial-29112006.txt


Regards,


	Igmar

