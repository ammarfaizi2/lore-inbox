Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267183AbUBMTac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbUBMTac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:30:32 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:56736 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S267183AbUBMTa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:30:27 -0500
Date: Fri, 13 Feb 2004 12:30:46 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Message-ID: <20040213193046.GA17790@bounceswoosh.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <402C0D0F.6090203@techsource.com> <20040213055350.GG29363@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040213055350.GG29363@alpha.home.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13 at  6:53, Willy Tarreau wrote:
>It depends on the disk too. Lots of disks (specially IDE) are far slower
>on writes than they are on reads.

This may be a function of the operating system or the filesystem, but
it isn't necessarilly an artifact of the drives themselves.  With both
read and write caching enabled, random writes will always be faster
than random reads from the drive perspective.

Even with queueing enabled (legacy TCQ or Native-SATA "NCQ"), your
ability to reorder reads is limited in ATA to 32 tags, while the
ability to reorder cached writes is limited only by buffer size and
cache granularity...  the absolute worst-case write performance should
be the same as read performance.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

