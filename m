Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUHJTS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUHJTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267677AbUHJTRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:17:07 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:61293 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267669AbUHJTQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:16:11 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Josh Aas <josha@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steiner@sgi.com
Subject: Re: bkl cleanup in do_sysctl
X-Message-Flag: Warning: May contain useful information
References: <4118FE9D.2050304@sgi.com> <1092158905.11212.18.camel@nighthawk>
	<1092163919.782.54.camel@mindpipe>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 10 Aug 2004 12:16:08 -0700
In-Reply-To: <1092163919.782.54.camel@mindpipe> (Lee Revell's message of
 "Tue, 10 Aug 2004 14:51:59 -0400")
Message-ID: <52n0126byf.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Aug 2004 19:16:08.0342 (UTC) FILETIME=[7D677B60:01C47F0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Lee> Someone once suggested that newbies who show up on LKML
    Lee> wanting to learn kernel hacking should be assigned to find
    Lee> one use of the BKL and replace it with proper locking.

Unfortunately most of the remaining BKL uses seem to be very subtle.
Removing lock_kernel() correctly requires a deep understanding of the
global locking semantics and may be very invasive.  In the end it's
also hard to be sure bugs haven't been introduced.

    Lee> For example reiserfs uses the BKL for all write locking (!),
    Lee> but it probably would not be too hard to fix, because you can
    Lee> just look at another filesystem that has proper locking.

Fixing up a filesystem's write locking doesn't sound like a very good
newbie project to me.

 - R.
