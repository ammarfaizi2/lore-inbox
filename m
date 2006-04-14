Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWDNPAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWDNPAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 11:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWDNPAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 11:00:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21386 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964992AbWDNPAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 11:00:18 -0400
Subject: Re: [Ext2-devel] [RFC][8/21]ext3 modify variables to exceed 2G
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net
In-Reply-To: <208e01c65fa5$17a3c850$4168010a@bsd.tnes.nec.co.jp>
References: <20060413160657sho@rifu.tnes.nec.co.jp>
	 <20060413171445.GT17364@schatzie.adilger.int>
	 <208e01c65fa5$17a3c850$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 14 Apr 2006 07:59:23 -0700
Message-Id: <1145026763.4488.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 18:23 +0900, Takashi Sato wrote:
> Thank you for your comment, Andreas.
> 
> > Takashi-san, please, it would make the code much more maintainable if the
> > changes made here would use new types for filesystem-wide block offsets
> > and for file-relative block offsets, as was previously discussed, instead
> > of just changing some variables to be unsigned long.  Like:
> > 
> > typedef unsigned long ext3_fsblk_t; # block offset in the filesystem
> > typedef unsigned long ext3_fscnt_t; # block count in the filesystem
> > typedef unsigned long ext3_fileblk_t; # block offset in a file
> 
> I agree that, but it will need a lots of work...
> Mingming, you got same comment from Andreas in "Extend ext3
> filesystem limit from 8TB to 16TB", did you do something about
> this?

No, I haven't get chance to do it yet. Please feel free to take it.:)

Laurent did some ground work for the filesystem wide physical block
number in his 64 bit ext3 patches. He changed physical block number from
"unsigned long" to "sector_t", that's probably a good start.

BTW, I think we should have one more:

typedef long ext3_grpblk_t; # block offset in the block group


Mingming

