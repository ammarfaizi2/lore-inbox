Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbUA0T3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUA0T3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:29:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:63166 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265610AbUA0T3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:29:45 -0500
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>
In-Reply-To: <1075230933.11207.84.camel@suprafluid>
References: <1075230933.11207.84.camel@suprafluid>
Content-Type: text/plain
Message-Id: <1075231718.21763.28.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 13:28:38 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 13:15, Florian Huber wrote:
> Hello MLs,
> today I switched from no-raid to linux kernel software raid 1 on a jfs
> and a ext3 partition. Both are working fine, but jfs_fsck reports an
> error on the jfs md device (md2 <-- hda3+hdc3):
> 
> Superblock is corrupt and cannot be repaired 
> since both primary and secondary copies are corrupt. 
> 
> Did I miss something? jfs_fsck runs without any error on hda3 and hdc3,
> but fails on md2.

I wonder if JFS is having trouble getting the partition size.  Can you
run jfs_fsck with the -v flag to see what part of the superblock it
doesn't like?

> I'm using the 2.6.2-rc2 kernel with raid autodetection.
> 
> TIA
> 	Florian

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

