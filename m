Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbVIOBKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVIOBKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVIOBKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:10:19 -0400
Received: from central-air-conditioning.toybox.cambridge.ma.us ([69.25.196.71]:32415
	"EHLO central-air-conditioning.toybox.cambridge.ma.us")
	by vger.kernel.org with ESMTP id S1030316AbVIOBKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:10:17 -0400
From: Marc Horowitz <marc@mit.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Horms <horms@debian.org>, 328135@bugs.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process stuck in disk wait
References: <20050913194707.8C8C28E6F0@ayer.connecterra.net>
	<20050914025150.GR27828@verge.net.au>
	<1126742335.8807.74.camel@lade.trondhjem.org>
Date: Wed, 14 Sep 2005 21:10:02 -0400
In-Reply-To: <1126742335.8807.74.camel@lade.trondhjem.org> (Trond Myklebust's
	message of "Thu, 15 Sep 2005 00:58:55 +0100")
Message-ID: <t533bo75e6t.fsf@central-air-conditioning.toybox.cambridge.ma.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>> on den 14.09.2005 Klokka 11:51 (+0900) skreiv Horms:
>> > Hi Marc,
>> > 
>> > would is be possible to test linux-image-2.6.12-1-686-smp from 
>> > unstable to see if this problem persists? I am CCing the NFS
>> > maintainer and LKML as this looks reasonably nasty and they
>> > may be interested in looking into it.
>> > 
>> 
>> I doubt this has anything to do with NFS. We should no longer have a
>> sync_page VFS method in the 2.6 kernels. What other filesystems is the
>> user running?

In the stack trace I sent, from a running 2.6.11 kernel, vfs_read
appears to be the vfs method, not sync_page.  sync_page is called much
deeper in the stack trace.

I haven't had a chance to try a 2.6.12 kernel, but I should be able to
this week.

                Marc
