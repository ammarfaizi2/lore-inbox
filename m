Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUG2QSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUG2QSC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUG2QRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:17:46 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:7074 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267572AbUG2QQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:16:21 -0400
Date: Thu, 29 Jul 2004 18:14:53 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.8-rc2][XFS] Page allocation failure
Message-ID: <20040729161453.GA4239@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040725173022.GA8345@dreamland.darkstar.lan> <20040729010403.GC800@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729010403.GC800@frodo>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Jul 29, 2004 at 11:04:03AM +1000, Nathan Scott ha scritto: 
> Hi there,
> 
> On Sun, Jul 25, 2004 at 07:30:23PM +0200, Kronos wrote:
> > ...
> > It seems that XFS failed an order 5 allocation (not atomic) on the read
> 
> Hmm, that file is fragmented up the wazoo for some reason
> (see the xfs_bmap -vv output on the file).  Any chance you
> know how it was written originally?

I think it was written by azureus (bt client), it creates a sparse file
and writes small blocks (usally 256KB) when they are downloaded (in
radom order). The partition had 1GB free (of 10GB) and I run xfs_fsr at
night.

> In particular, was it written with O_SYNC set?  (or via a sync NFS
> mount?).

I don't think so, I gave a look at sources it seems using memory mapped
files.

Luca
-- 
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel
