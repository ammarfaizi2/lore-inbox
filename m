Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbUAPSku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUAPSku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:40:50 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:42485 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265577AbUAPSkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:40:47 -0500
Date: Fri, 16 Jan 2004 10:40:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Patrick Mau <mau@oscar.ping.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [2.6] nfs_rename: target $file busy, d_count=2
Message-ID: <20040116184031.GM1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Patrick Mau <mau@oscar.ping.de>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20040116050642.GF1748@srv-lnx2600.matchmail.com> <20040116130336.GA5220@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116130336.GA5220@oscar.prima.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 02:03:36PM +0100, Patrick Mau wrote:
> On Thu, Jan 15, 2004 at 09:06:42PM -0800, Mike Fedyk wrote:
> > Can anyone reproduce?
> 
> Hi,
> 
> I was able to reproduce stale handles a long time ago.
> A workable solution for me was to export using 'no_subtree_check'
> on the server. Like this:
> 
> /data \
>   tony.local.net(rw,sync,no_root_squash,no_subtree_check) \
> 
> Could you please try and reply to my address if t works ?

I'll have to give it a try next time I get a chance to reboot this server.

I only had a few nfs clients doing light load, (kde home directories, and
such) and was able to reproduce stale nfs file handles just by running "find
> /dev/null" on the nfs share.

Have you tried the -mm tree recently?  2.6.1-mm4 even has some new nfsd
patches in there (maybe you should wait until -mm5 though, there are a few
build problems and such), as well as over 20 nfs client patches.  Haven't
checked what they all do, but some of them are RPC_GSS support mixed in with
the bug fixes.

Mike
