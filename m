Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUIAPrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUIAPrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUIAPn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:43:59 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:8859 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267197AbUIAPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:42:07 -0400
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rlrevell@joe-job.com, mst@mellanox.co.il
Content-Type: text/plain
Organization: 
Message-Id: <1094053222.431.7165.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Sep 2004 11:40:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin writes:
> Quoting Lee Revell [snip -- that was excessive]

>> By adding a new ioctl you are adding a new use of
>> the BKL. It has been suggested on dri-devel that
>> this should be fixed.  Is this even possible?
>
> I dont know - can the lock be released before the
> call to filp->f_op->ioctl ?
>
> I assume the reason its there is for legacy
> code - existing ioctls may be assuming the BKL
> is taken, but maybe there could be another flag
> in f_ops to let sys_ioctl release the lock before
> doing the call ...
>
> Like this - would that be safe?

Yes. It is proven to work.


