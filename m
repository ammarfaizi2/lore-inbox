Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUD2CMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUD2CMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUD2CMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:12:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:18594 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262850AbUD2CMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:12:13 -0400
Date: Wed, 28 Apr 2004 19:11:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Craig Thomas <craiger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Message-Id: <20040428191154.0d390b0f.akpm@osdl.org>
In-Reply-To: <1083200520.1923.111.camel@bullpen.pdx.osdl.net>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<1083200520.1923.111.camel@bullpen.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Thomas <craiger@osdl.org> wrote:
>
> I have taken a quick look at the results and I see no degredations
>  from 2.6.6-rc2 and the performance looks much better than the 
>  2.6.5 kernel for dbt3 (as reported earlier).

The 70% dbt3 improvement is extremely fishy.  Yes, there are things in
2.6.6-rc3 which could improve database workloads by that much, but dbt3
doesn't appear to be using them.

Again, the vmstat traces indicate that after a run on 2.6.6-rc3 we have a
full gigabyte less used pagecache than with 2.6.5.  In both cases there is
still a lot of free memory.  Which tends to indicate that the -rc3 run was,
for some reason, not an equivalent workload - it's using a smaller dataset.

I'd suggest that you double-check these results, try and work out why the
-rc3 run is touching less data.  Maybe go back and redo the 2.6.5 test?
