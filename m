Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVCDK1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVCDK1X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVCDK1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:27:23 -0500
Received: from gate.in-addr.de ([212.8.193.158]:6594 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261282AbVCDK1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:27:12 -0500
Date: Fri, 4 Mar 2005 11:27:27 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Junfeng Yang <yjf@stanford.edu>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiser@namesys.com,
       mc@cs.stanford.edu
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync option?
Message-ID: <20050304102726.GS14495@marowsky-bree.de>
References: <20050304011141.5ff037dc.akpm@osdl.org> <Pine.GSO.4.44.0503040136010.9975-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.44.0503040136010.9975-100000@elaine24.Stanford.EDU>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-03-04T01:44:06, Junfeng Yang <yjf@stanford.edu> wrote:

> > That would be a bug.  Please send the e2fsck output.
> 
> Here is the trace
> 
> 1. file system is made with sbin/mkfs.ext2 -F -b 1024 /dev/hda9 60
> and  mounted with -o sync,dirsync
> 
> 1.  operations FiSC did:
> 
> creat(/mnt/sbd0/0001)
> write(/mnt/sbd0/0001)
> rename(/mnt/sbd0/0001, /mnt/sbd0/0002)
> mkdir(/mnt/sbd0/0003)
> 
> 2.  FiSC "crashed" the test machine  after mkdir returns.  Crashed
> disk image can be downloaded at: http://fisc.stanford.edu/bug2/crash.img.bz2

I've run into similar issues. For example, a "touch foo" also isn't
synchronous with -o sync, but stays entirely in the cache. Andrea tells
me this is expected behaviour, so I've given up on this one...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

