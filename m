Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUJLOcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUJLOcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJLOcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:32:09 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:7826 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S264704AbUJLO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:29:09 -0400
Date: Wed, 13 Oct 2004 00:29:43 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@digeo.com, adilger@clusterfs.com
Subject: ext3 error with 2.6.9-rc4
Message-ID: <20041012142943.GD920@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fs is on a 200gb seagate hd on a promise pci card (20267 - latest
firmware). It's hdh1. I was tarring a fs on hde1 onto hdh1. It ran for a
bit and then stopped with my kern.log providing the following error:

Oct 13 00:12:03 nessie kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1): ext3_readdir: bad entry in directory #3522561: rec_len is smaller than minimal - offset=4084, inode=3523431, rec_len=0, name_len=0
Oct 13 00:17:03 nessie kernel: Aborting journal on device hdh1.
Oct 13 00:17:03 nessie kernel: ext3_abort called.
Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1): ext3_journal_start: Detected aborted journal
Oct 13 00:17:03 nessie kernel: Remounting filesystem read-only
Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1) in start_transaction: Journal has aborted
Oct 13 00:17:58 nessie kernel: __journal_remove_journal_head: freeing b_committed_data

A similarish error occured under 2.6.8-rc2:

Sep 19 07:39:29 nessie kernel: attempt to access beyond end of device
Sep 19 07:39:29 nessie kernel: hdh1: rw=1, want=3186822344, limit=390716802
Sep 19 07:39:29 nessie kernel: Aborting journal on device hdh1.
Sep 19 07:39:29 nessie kernel: ext3_abort called.
Sep 19 07:39:29 nessie kernel: EXT3-fs abort (device hdh1): ext3_journal_start: Detected aborted journal
Sep 19 07:39:29 nessie kernel: Remounting filesystem read-only
Sep 19 07:39:29 nessie kernel: EXT3-fs error (device hdh1) in
start_transaction: Journal has aborted

This was during a copy from hde2 to hdh1. 2.6.9-rc4 survived this bit
but died anyway when more data was written to the fs when tarring.

The HD is brand new.

Any help I can provide in helping debug this I will gladly give. Just
give me a shout.

-- 
    Red herrings strewn hither and yon.
