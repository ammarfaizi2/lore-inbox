Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUHNIvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUHNIvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 04:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUHNIvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 04:51:52 -0400
Received: from holomorphy.com ([207.189.100.168]:40856 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264697AbUHNIvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 04:51:24 -0400
Date: Sat, 14 Aug 2004 01:51:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Lawrence E. Freil" <lef@freil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Message-ID: <20040814085103.GT11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Lawrence E. Freil" <lef@freil.com>, linux-kernel@vger.kernel.org
References: <200408140211.i7E2BNSg027992@dogwood.freil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408140211.i7E2BNSg027992@dogwood.freil.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 10:11:23PM -0400, Lawrence E. Freil wrote:
> I'm following the kernel bug reporting format so:
> 1. Linux 2.6.7 kernel slowdown in directory access with HIMEM on
> 2. I have discovered an issue with the Linux 2.6.7 kernel when HIMEM is
>    enabled which exhibits itself as a slowdown in directory access regardless
>    of filesystem used.  When HIMEM is disabled the performance returns to
>    normal.  The test I ran was a simple "/usr/bin/time ls -l" of a directory
>    with 3000 empty files.  With HIMEM enabled in the kernel this takes
>    approximately 1.5 seconds.  Without HIMEM it takes 0.03 seconds.  The
>    time is 100% CPU and no I/O operations are done to disk.  "time" reports
>    there are 460 "minor" page faults with zero "major" page faults.
>    I believe the issue here is the mapping of pages between high-mem and
>    lowmem in the kernel paging code.  This increase in time for directory
>    accesses doubles to triples times for applications using samba.
>    I have also tested this on another system which had only 512Meg of RAM
>    but with HIMEM set in the kernel and did not experience the problem.
>    I believe it only effects the performance when the paging buffers end
>    up in highmem.

Please try to reproduce this with CONFIG_HIGHMEM=y but using mem=700M
This will tell me something useful beyond "boot with less RAM".

-- wli
