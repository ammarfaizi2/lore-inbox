Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUE1OID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUE1OID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUE1OID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:08:03 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:29962 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S263124AbUE1OHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:07:31 -0400
Subject: Re: Process hangs on blk_congestion_wait copying large file to
	cifs filesystem
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1085672706.4350.9.camel@taz.graycell.biz>
References: <1085672706.4350.9.camel@taz.graycell.biz>
Content-Type: text/plain
Organization: Graycell
Date: Fri, 28 May 2004 15:07:29 +0100
Message-Id: <1085753249.2219.13.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2004 14:03:32.0609 (UTC) FILETIME=[8F8C3F10:01C444BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qui, 2004-05-27 at 16:45 +0100, Nuno Ferreira wrote:
> Hi,
> I'm trying to copy a large file (200Mb or bigger) from an ext3
> filesystem to a windows share mounted using CIFS and the cp process
> hangs, sometimes for a long time (several minutes).
> Calling ps, I can see that it's blocking on blk_congestion_wait.
> 
> Trying to edit a file on the same ext3 filesystem using vi blocks on the
> same function. However, during that that same time that vi and cp were
> blocked, I was able to do a "find /usr/share/doc" and it completed
> normally, in a few seconds.
> 
> Eventually the copy succeeds but it takes a long time (20 minutes to
> copy 200Mb) and the computer is unusable during most of that time.
> 
> This is copying from my laptop (IDE disk), the network card is a RTL8139
> using 8139cp drivers.
> 
> Is someone seeing a similiar problem? What extra info is needed to debug
> it?

Mmm, anyone with a similar problem? What should I do, make a profile
like explained in Documentation/basic_profiling.txt or is the above
information about the function where the processes are "stuck" enough?
One thing I forgot to mention, during the several minutes the processes
are stuck on that function there is no disk activity, so it's not the
processes being starved. In fact, there is no other activity on the
machine apart from the copy.

-- 
Nuno Ferreira

