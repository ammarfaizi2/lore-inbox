Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269962AbUJNEMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269962AbUJNEMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269960AbUJNEMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:12:32 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:59097 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S269962AbUJNEMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:12:06 -0400
Date: Wed, 13 Oct 2004 22:12:03 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ext3 error with 2.6.9-rc4
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <00ce01c4b1a3$f63599b0$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.cbe1dra.16ke3gi@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried fsck on that file system? Sounds like it may be corrupted somehow.


----- Original Message ----- 
From: "CaT" <cat@zip.com.au>
Newsgroups: fa.linux.kernel
To: <linux-kernel@vger.kernel.org>
Cc: <sct@redhat.com>; <akpm@digeo.com>; <adilger@clusterfs.com>
Sent: Tuesday, October 12, 2004 8:43 AM
Subject: ext3 error with 2.6.9-rc4


> The fs is on a 200gb seagate hd on a promise pci card (20267 - latest
> firmware). It's hdh1. I was tarring a fs on hde1 onto hdh1. It ran for a
> bit and then stopped with my kern.log providing the following error:
>
> Oct 13 00:12:03 nessie kernel: EXT3-fs: mounted filesystem with ordered 
> data mode.
> Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1): ext3_readdir: 
> bad entry in directory #3522561: rec_len is smaller than minimal - 
> offset=4084, inode=3523431, rec_len=0, name_len=0
> Oct 13 00:17:03 nessie kernel: Aborting journal on device hdh1.
> Oct 13 00:17:03 nessie kernel: ext3_abort called.
> Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1): 
> ext3_journal_start: Detected aborted journal
> Oct 13 00:17:03 nessie kernel: Remounting filesystem read-only
> Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1) in 
> start_transaction: Journal has aborted
> Oct 13 00:17:58 nessie kernel: __journal_remove_journal_head: freeing 
> b_committed_data
>
> A similarish error occured under 2.6.8-rc2:
>
> Sep 19 07:39:29 nessie kernel: attempt to access beyond end of device
> Sep 19 07:39:29 nessie kernel: hdh1: rw=1, want=3186822344, 
> limit=390716802
> Sep 19 07:39:29 nessie kernel: Aborting journal on device hdh1.
> Sep 19 07:39:29 nessie kernel: ext3_abort called.
> Sep 19 07:39:29 nessie kernel: EXT3-fs abort (device hdh1): 
> ext3_journal_start: Detected aborted journal
> Sep 19 07:39:29 nessie kernel: Remounting filesystem read-only
> Sep 19 07:39:29 nessie kernel: EXT3-fs error (device hdh1) in
> start_transaction: Journal has aborted
>
> This was during a copy from hde2 to hdh1. 2.6.9-rc4 survived this bit
> but died anyway when more data was written to the fs when tarring.
>
> The HD is brand new.
>
> Any help I can provide in helping debug this I will gladly give. Just
> give me a shout.
>
> -- 
>    Red herrings strewn hither and yon.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

