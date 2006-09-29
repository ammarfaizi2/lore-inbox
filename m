Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161312AbWI2ELZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWI2ELZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 00:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWI2ELY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 00:11:24 -0400
Received: from paragon.brong.net ([66.232.154.163]:18898 "EHLO
	paragon.brong.net") by vger.kernel.org with ESMTP id S1161312AbWI2ELY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 00:11:24 -0400
Date: Fri, 29 Sep 2006 14:11:15 +1000
From: Bron Gondwana <brong@fastmail.fm>
To: Dax Kelson <dax@gurulabs.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Theodore Bullock <tbullock@nortel.com>, robm@fastmail.fm,
       erich@areca.com.tw, linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
Message-ID: <20060929041115.GA9660@brong.net>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm> <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com> <20060731200309.bd55c545.akpm@osdl.org> <1154530428.3683.0.camel@mulgrave.il.steeleye.com> <1156375551.4306.10.camel@mentorng.gurulabs.com> <1156392717.26289.44.camel@mulgrave.il.steeleye.com> <1156401274.4256.53.camel@thud.gurulabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156401274.4256.53.camel@thud.gurulabs.com>
Organization: brong.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 12:34:34AM -0600, Dax Kelson wrote:
> Areca hardware owners have been experiencing the out-of-tree pain for a
> long time. James is happy with the quality, it is a new driver, well
> tested, has been shipped by a major distro. People have had the ample
> chance to voice concerns.
> 
> Why prolong the pain? Hook a brother up already.

Thanks James and Erich for your great work in getting this driver
ready for inclusion and making sure it will be in 2.6.19.  It will
be nice to not have to apply the patch to every kernel I build!

Bron.

http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.18-git10.log

commit d67a70aca200f67be42428e74eb3353f20ad1130 
tree 863562f74854295bfdf60eb26375ff984d8a2d4d 
parent 43d6b68dc38867e489995e21649bb82f6ee7b5d3 
author James Bottomley <James.Bottomley@steeleye.com> Fri, 28 Jul 2006 17:36:46 -0500 
committer James Bottomley <jejb@mulgrave.il.steeleye.com> Wed, 02 Aug 2006 10:53:18 -0400 

    [SCSI] arcmsr: fix up sysfs values
    
    The sysfs files in arcmsr are non-standard in that they aren't simple
    filename value pairs, the values actually contain preceeding text which
    would have to be parsed.  The idea of sysfs files is that the file name
    is the description and the contents is a simple value.
    
    Fix up arcmsr to conform to this standard.
    
    Acked-By: Erich Chen <erich@areca.com.tw>
    Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

commit 1c57e86d75cf162bdadb3a5fe0cd3f65aa1a9ca3 
tree 166f691c186d6e663218559c4762299063f63657 
parent 0c269e6d3c615403a6e0acbe6e88f1c0da9c2396 
author Erich Chen <erich@areca.com.tw> Wed, 12 Jul 2006 08:59:32 -0700 
committer James Bottomley <jejb@mulgrave.il.steeleye.com> Fri, 28 Jul 2006 14:13:40 -0500 

    [SCSI] arcmsr: initial driver, version 1.20.00.13
    
    arcmsr is a driver for the Areca Raid controller, a host based RAID
    subsystem that speaks SCSI at the firmware level.
    
    This patch is quite a clean up over the initial submission with
    contributions from:
    
    Randy Dunlap <rdunlap@xenotime.net>
    Christoph Hellwig <hch@lst.de>
    Matthew Wilcox <matthew@wil.cx>
    Adrian Bunk <bunk@stusta.de>
    
    Signed-off-by: Erich Chen <erich@areca.com.tw>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
