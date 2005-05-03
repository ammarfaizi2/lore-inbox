Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVECCwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVECCwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 22:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVECCwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 22:52:20 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:64028 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261321AbVECCv1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 22:51:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qHGqr1+J1PTLYEk+pnzGed83gKKlOghLgyi+xdsKczu6jWfu3Zykis/91yZnRIBFGszRhaFT9Z/iVGhQNTIbv9IITIf61cMjN7UivC7rwUoKi+8ckl2O0RRDzposPigBzPBlcEYkoi63+jrZOcv2XYCqBwSZKTHwphaLPxKIt4g=
Message-ID: <d4757e6005050219514ece0c0a@mail.gmail.com>
Date: Mon, 2 May 2005 22:51:24 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Empty partition nodes not created (was device node issues with recent mm's and udev)
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, first off I'd like to say, I am on 2.6.12-rc3-mm2, and this issue
is not fixed at all.  Secondly, I'd like to say that I've pinpointed
it a bit more.  It appears only Empty partitions (type 0 in fdisk) do
not create device nodes.

Here is the partition table from fdisk, fdisk does run fine.. its just
the fact this node is not created that threw me off before.

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1   *           1           2       16033+   0  Empty
/dev/sdb2   *           6        2431    19486845    b  W95 FAT32
/dev/sdb3               3           5       24097+  83  Linux


Notice, /dev/sdb1 is a Empty partition... in /dev I only have sdb,
sdb2, and sdb3.  No sdb1.  Any help would be appreciated.

Thanks,
Joe
