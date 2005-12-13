Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVLMGQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVLMGQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 01:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVLMGQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 01:16:28 -0500
Received: from tornado.reub.net ([202.89.145.182]:54671 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932473AbVLMGQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 01:16:28 -0500
Message-ID: <439E6730.5040602@reub.net>
Date: Tue, 13 Dec 2005 19:16:16 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051212)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: 2.6.15-rc5-mm2
References: <5iylt-514-17@gated-at.bofh.it>
In-Reply-To: <5iylt-514-17@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2005 1:20 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/
> 
> - Many new driver updates and architecture updates
> 
> - New CPU scheduler policy: SCHED_BATCH.
> 
> - New version of the hrtimers code.

Works fine.  However now that Redhat Rawhide contains gcc version 4.1.0 20051207 
(Red Hat 4.1.0-0.6) I'm seeing quite a few compile warnings, one in particular 
appearing in hundreds of lines:

In file included from include/asm/mpspec.h:5,
                  from include/asm/smp.h:18,
                  from include/linux/smp.h:22,
                  from include/linux/sched.h:26,
                  from include/linux/module.h:10,
                  from drivers/net/sky2.c:39:
include/asm/mpspec_def.h:78: warning: 'packed' attribute ignored for field of 
type 'unsigned char[5u]'


There is a patch in the Fedora Core Kernel RPM that 'fixes' this for the FC kernels:

http://cvs.fedora.redhat.com/viewcvs/devel/kernel/linux-2.6-gcc41.patch
http://cvs.fedora.redhat.com/viewcvs/devel/kernel/linux-2.6-gcc41.patch?rev=1.3&view=markup

Perhaps part or all of it could go into -mm for further testing?  Is this a gcc 
glitch or something that ought to be fixed in the kernel?  (davej?)


reuben
