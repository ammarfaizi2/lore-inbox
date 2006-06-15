Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWFOKNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWFOKNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 06:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWFOKNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 06:13:51 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:43914 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932132AbWFOKNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 06:13:49 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17553.12734.272321.820052@gargle.gargle.HOWL>
Date: Thu, 15 Jun 2006 14:09:02 +0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Nathan Scott <nathans@sgi.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  Slimming down struct inode
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.61.0606150127080.14257@yvahk01.tjqt.qr>
References: <20060613143230.A867599@wobbly.melbourne.sgi.com>
	<448EC51B.6040404@argo.co.il>
	<20060614084155.C888012@wobbly.melbourne.sgi.com>
	<17551.58643.704359.815153@gargle.gargle.HOWL>
	<Pine.LNX.4.61.0606150127080.14257@yvahk01.tjqt.qr>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt writes:
 > >
 > >Sorry, but why this operation is needed? Generic code (in fs/*.c)
 > >doesn't use ->i_blksize at all. If XFS wants to provide per-inode
 > >st_blksize, all it has to do is to store preferred buffer size in its
 > >file system specific inode (struct xfs_inode), and use something
 > >different from generic_fillattr() as its ->i_op->getattr() callback
 > >(xfs_vn_getattr()).
 > >
 > By the way, are there any significant userspace applications that use 
 > i_blksize/i_blkbits?
 > 

cp(1), db(3) or any other using st_blksize field of struct statbuf to
select the size of IO buffer.

 > 
 > Jan Engelhardt
 > -- 

Nikita.
