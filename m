Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265437AbUAPNDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUAPNDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:03:54 -0500
Received: from p508EF605.dip.t-dialin.net ([80.142.246.5]:21382 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S265437AbUAPNDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:03:52 -0500
Date: Fri, 16 Jan 2004 14:03:36 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Fwd: Re: [2.6] nfs_rename: target $file busy, d_count=2
Message-ID: <20040116130336.GA5220@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
References: <20040116050642.GF1748@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116050642.GF1748@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 09:06:42PM -0800, Mike Fedyk wrote:
> On Thu, Jan 15, 2004 at 04:54:57PM -0800, Mike Fedyk wrote:
> > On Thu, Jan 15, 2004 at 04:03:46PM -0800, Mike Fedyk wrote:
> > > Both client and server are running the same 2.6.1-bk2 kernel with TCP-NFS.
> > > SMP, Highmem, & preempt.
> > 
> > I have four clients that are all having this problem also, three 2.6, and
> > one 2.4 client.
> > 
> > Using TCP-NFS they all have stale nfs handles even after a reboot (only
> > rebooted one to try with 2.4.23), but changed one to UDP-NFS, and it didn't
> > have the stale handles.
> > 
> > Will do more testing with UDP-NFS.
> 
> No, TCP and UDP NFS both get stale file handles. :(
> 
> Can anyone reproduce?

Hi,

I was able to reproduce stale handles a long time ago.
A workable solution for me was to export using 'no_subtree_check'
on the server. Like this:

/data \
  tony.local.net(rw,sync,no_root_squash,no_subtree_check) \

Could you please try and reply to my address if t works ?

Thanks,
Patrick
