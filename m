Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUDBJcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbUDBJcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:32:41 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:49832 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S263571AbUDBJcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:32:39 -0500
Date: Fri, 2 Apr 2004 01:32:38 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Carsten Gaebler <ezinye-zinto@snakefarm.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.25 XFS can't create files
Message-ID: <20040402093238.GA28931@dingdong.cryptoapps.com>
References: <406D20FE.8040701@snakefarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406D20FE.8040701@snakefarm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc-'d to the linux-xfs list)

 On Fri, Apr 02, 2004 at 10:14:54AM +0200, Carsten Gaebler wrote:

> I have somewhat of an esoteric problem. I can create an XFS on an
> external fibre channel RAID attached to an LSI fibre channel card
> (Fusion MPT driver) but I can't create files or directories on that
> filesystem (Permission denied). ext2/ext3 work fine on the same
> partition, so I suspect this is an XFS+MPT issue.

I suspect it's not MPT related.  I'm not farmiliar with stock 2.4.25
but assume the XFS merge went OK and everything is sane.  Any chance
you can test with a CVS kernel from oss.sgi.com to rule out the
(probably minor) differences there?

> sq22:~# touch /mnt/xfs/foo
> touch: creating `/mnt/xfs/foo': Permission denied

strace shows open/creat failing?  there are also no ACLs and/or
security modules involved are there?

