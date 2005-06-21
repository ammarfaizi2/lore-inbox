Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVFUBdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVFUBdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFUBbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 21:31:10 -0400
Received: from amanpulo.hosting.qsr.com.ph ([64.34.170.22]:59616 "EHLO
	amanpulo.hosting.qsr.com.ph") by vger.kernel.org with ESMTP
	id S261877AbVFUBQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 21:16:03 -0400
Date: Tue, 21 Jun 2005 09:15:52 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.12] XFS: Undeletable directory
Message-ID: <20050621011552.GC4927@free.net.ph>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <200506191904.49639.lkml@kcore.org> <20050620070459.GB1549@frodo> <200506201225.11129.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506201225.11129.lkml@kcore.org>
X-Personal-URL: http://jijo.free.net.ph
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 12:25:10PM +0200, Jan De Luyck wrote:
> On Monday 20 June 2005 09:04, Nathan Scott wrote:
> > If it comes to it, you can always zero out individual inode fields
> > for that inode in xfs_db (with -x option to enable write mode) and
> > then xfs_repair should be able to get past it.
> 
> Any idea how this should be set?

    # xfs_db -x -c 'inode XXX' -c 'write core.nextents 0' -c 'write core.size 0' /dev/hdXX

Cheers!

 --> Jijo

-- 
Federico Sevilla III : jijo.free.net.ph : When we speak of free software
GNU/Linux Specialist : GnuPG 0x93B746BE : we refer to freedom, not price.
