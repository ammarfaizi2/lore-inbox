Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWHRMUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWHRMUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWHRMUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:20:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:45196 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030366AbWHRMUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:20:06 -0400
Subject: Re: 2.6.18-rc4-mm1  BUG null pointer deref while saving a file
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve French <smfltc@us.ibm.com>
In-Reply-To: <44E57931.1010607@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <44E30517.10603@aitel.hist.no>
	 <1155738526.9367.6.camel@kleikamp.austin.ibm.com>
	 <44E57931.1010607@aitel.hist.no>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 07:20:04 -0500
Message-Id: <1155903604.7255.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 10:24 +0200, Helge Hafting wrote:
> Dave Kleikamp wrote:
> > On Wed, 2006-08-16 at 13:44 +0200, Helge Hafting wrote:

> >> Aug 16 13:20:30 hh kernel: Call Trace:
> >> Aug 16 13:20:30 hh kernel:  [<c0466bc7>] __down_failed+0x7/0xc
> >> Aug 16 13:20:30 hh kernel: DWARF2 unwinder stuck at __down_failed+0x7/0xc
> >> Aug 16 13:20:31 hh kernel: Leftover inexact backtrace:
> >> Aug 16 13:20:31 hh kernel:  [<c01ed987>] .text.lock.file+0x54/0x9d
> >> Aug 16 13:20:31 hh kernel:  [<c01516bd>] __fput+0xb2/0x163
> >> Aug 16 13:20:31 hh kernel:  [<c014ee9d>] filp_close+0x3e/0x62
> >> Aug 16 13:20:31 hh kernel:  [<c0150168>] sys_close+0x5c/0x6b
> >> Aug 16 13:20:31 hh kernel:  [<c01028c9>] sysenter_past_esp+0x56/0x79
> >>     
> >
> > By any chance would you be using cifs?  This looks just like the bug
> > that is fixed by this patch:
> > http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/sfrench/cifs-2.6.git;a=commitdiff;h=e466e4876bf39474e15d0572f2204578137ae7f5
> >   
> Yes, this is on cifs.  I should have mentioned that.  Is this patch going
> in anyway, or should I test it?  I don't know a way of reproducing
> the problem.

This git tree is automatically pulled into the -mm build, so it will be
in the next -mm build.  The patch causing the problem isn't in mainline
yet, so there is no rush to fix it there.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

