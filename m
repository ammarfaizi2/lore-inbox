Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUDWXgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUDWXgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUDWXgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:36:18 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:48369 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261723AbUDWXgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:36:11 -0400
Date: Fri, 23 Apr 2004 16:34:20 -0700
From: Paul Jackson <pj@sgi.com>
To: root@chaos.analogic.com
Cc: joelja@darkwing.uoregon.edu, miller@techsource.com, tytso@mit.edu,
       miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-Id: <20040423163420.43f55a90.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.53.0404231624010.1352@chaos>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu>
	<Pine.LNX.4.53.0404231624010.1352@chaos>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you want to have fast disks, then you should do what I
> suggested to Digital 20 years ago when they had ST-506
> interfaces and SCSI was available only from third-parties.
> It was called "striping" (I'm serious!).

That gets your bandwidth up, but does nothing for latency.

Depending on your workload, that may or may not be critical.

As a former SGI employee noted:

  "Money can buy bandwidth, but latency is forever" -- John Mashey

To get latency down, you need fast rotating disks and short strokes
(waste most of the disk on little used data, or on nothing at all).
And even that won't get you much faster than 20 years ago.

That, or lots of main memory, or if the data is pretty much
read-only, perhaps some complicated data duplication.

But we're not in such bad shape there - folks have been dealing
with that speed difference for at least 20 years ;).

It's the speed difference between the processor and main memory
that's more challenging now - as it approaches speed differences
we once saw between processor and disk.

To heck with disk compression - it's time for main memory compression.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
