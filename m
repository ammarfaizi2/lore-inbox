Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUGTMCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUGTMCO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 08:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGTMCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 08:02:14 -0400
Received: from colin2.muc.de ([193.149.48.15]:7179 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265810AbUGTMCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 08:02:13 -0400
Date: 20 Jul 2004 14:02:11 +0200
Date: Tue, 20 Jul 2004 14:02:11 +0200
From: Andi Kleen <ak@muc.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1: Possible SCSI-related problem on dual Opteron w/ NUMA
Message-ID: <20040720120211.GA72772@muc.de>
References: <200407171826.03709.rjwysocki@sisk.pl> <20040717181240.GA67332@muc.de> <200407172109.38088.rjwysocki@sisk.pl> <200407181448.14614.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407181448.14614.rjwysocki@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had this problem again this morning.  I was unpacking the kernel tarball to 
> /dev/sda8 and it went south (the tarball had been partially unpacked before 
> the partition was remounted r-o).  Then, I got back to 2.6.7 and ran fsck - 
> now it found some errors (obviously) and fixed them.  Next (on 2.6.7), I 
> unpacked the kernel to /dev/sda8 (again) and compiled the 2.6.8-rc2.  I ran 
> it, unpacked the kernel to /dev/sda8 (again) and compiled it - everything 
> worked.  Then, I applied your patch on top of the newly created 2.6.8-rc2 
> tree and compiled the kernel.  After installing and running it I tried to 
> unpack the kernel to /dev/sda8 (again) and it went south, so I got back to 
> the "plain" 2.6.8-rc2, ran fsck and fixed the partition, unpacked the kernel 
> to /dev/sda8 - and it all worked.
> 
> So, it seems, there's something in your patch that causes this misbehavior.

In which patch eactly? x86_64-2.6.8rc1-1 or x86_64-2.6.8rc1-2 ? 

If it started with -2 can you check if -1 has the problem too?

-Andi
