Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFAEbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 00:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTFAEbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 00:31:42 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:57951 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261222AbTFAEbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 00:31:41 -0400
Date: Sat, 31 May 2003 21:45:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
Message-Id: <20030531214520.5b7facf4.akpm@digeo.com>
In-Reply-To: <1054441433.1722.33.camel@iso-8590-lx.zeusinc.com>
References: <1054441433.1722.33.camel@iso-8590-lx.zeusinc.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2003 04:45:04.0235 (UTC) FILETIME=[9176A3B0:01C327F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler <ttsig@tuxyturvy.com> wrote:
>
> I simply reniced this process to -10 and
>  everything started working fine.  Upon looking a little further it
>  seemed that the kernel was dynamically boosting the priority of the
>  process much higher than it probably should be, in the end, not leaving
>  enough CPU for playing the sounds without skipping.

Yes, it seems that too many real-world applications are accidentally
triggering this problem.

Could you please run an strace of the boosted process, find out what it is
doing to get itself boosted in this manner?  Wait until things are in
steady state and the process is boosted, then run `strace -tt <pid>' so we
see the timing info.


Thanks.
