Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTDHQ37 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbTDHQ37 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:29:59 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:45842 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S261393AbTDHQ35 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:29:57 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm1
Date: Tue, 8 Apr 2003 17:41:10 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200304081741.10129.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> . sparc64 is now using gcc-3.x, so there is a patch here to make 
>   gcc-2.95 the minimum required version.
> 
> . A few rmap-speedup patches reduce the rmap CPU tax by 25-30% on a P4
> 
> . Various other cleaups, speedups and fixups.

On attempting to boot this kernel, I get the following just before init:
Kernel panic: VFS: Unable to mount root fs on 03:05

2.5.67 base works fine. I discovered that reverting the following 
patches allows me to boot. I can increase the granularity of my search 
if nothing comes immediately to mind:

aggregated-disk-stats.patch
dynamic-hd_struct-allocation-fixes.patch
dynamic-hd_struct-allocation.patch

I reverted the aggregated-xx patch because it depends on the dynamic 
hd_struct work in a single line;

+               struct hd_struct *hd = gp->part[n];

Therefore it may not be this patch that is the source of the problem, 
but I backed it out anyway.

Cheers,
Alistair Strachan.

