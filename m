Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbTGISrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268471AbTGISrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:47:18 -0400
Received: from dnsc6804027.pnl.gov ([198.128.64.39]:43654 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S266068AbTGISrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:47:17 -0400
Date: Wed, 9 Jul 2003 11:51:48 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
Message-ID: <20030709115148.L4482@schatzie.adilger.int>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
	lkml <linux-kernel@vger.kernel.org>
References: <20030709133109.A23587@infradead.org> <20030709100336.H4482@schatzie.adilger.int> <Pine.LNX.4.55L.0307091421070.26373@freak.distro.conectiva> <16140.24322.464839.812346@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16140.24322.464839.812346@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jul 09, 2003 at 08:29:22PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 09, 2003  20:29 +0200, Trond Myklebust wrote:
> How about instead following Alan's suggestion to replace
> KERNEL_HAS_O_DIRECT with a KERNEL_HAS_O_DIRECT2 that can be used to
> switch between the old and new O_DIRECT format in the XFS patches?

Actually, I like that a lot more, as it allows out-of-tree code to
know which interface to use, and we don't have to key on kernel version
(which is bogus if compiling against a vendor kernel that back-ports
this fix).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

