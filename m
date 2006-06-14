Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWFNR2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWFNR2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWFNR2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:28:23 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:55479 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932125AbWFNR2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:28:22 -0400
Date: Wed, 14 Jun 2006 11:28:29 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: 7eggert@gmx.de
Cc: grundig <grundig@teleline.es>, jeff@garzik.org, alex@clusterfs.com,
       alan@lxorguk.ukuu.org.uk, chase.venters@clientec.com, torvalds@osdl.org,
       akpm@osdl.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060614172829.GM5964@schatzie.adilger.int>
Mail-Followup-To: 7eggert@gmx.de, grundig <grundig@teleline.es>,
	jeff@garzik.org, alex@clusterfs.com, alan@lxorguk.ukuu.org.uk,
	chase.venters@clientec.com, torvalds@osdl.org, akpm@osdl.org,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
References: <6lTUf-54A-17@gated-at.bofh.it> <6lU3S-5h5-11@gated-at.bofh.it> <6lU3X-5h5-35@gated-at.bofh.it> <6lUnl-5GL-5@gated-at.bofh.it> <6lUwX-66U-25@gated-at.bofh.it> <6lUQo-6w3-29@gated-at.bofh.it> <6lUQp-6w3-35@gated-at.bofh.it> <6lUZT-6HS-3@gated-at.bofh.it> <6nE4Z-4If-55@gated-at.bofh.it> <E1FqYV5-00047Z-A6@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FqYV5-00047Z-A6@be1.lrz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 14, 2006  18:45 +0200, Bodo Eggert wrote:
> BTW: Upgrading a filesystem by using mount options _and_ forcing that
> option to be supplied on subsequent mounts is a BUG. If should be what
> current code demands, it should be fixed ASAP. I hope that's not what
> the current code does.

If you don't remount with "-o extents" all it (currently) means is that
new files will not be created with extents.  Existing extent-mapped files
will continue to work.  It was done this way so that if some serious
problem was found with extents there was a fallback position to "normal"
block mapped files and the damage would be limited to files created while
mounted with "-o extents".

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

