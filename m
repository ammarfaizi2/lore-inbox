Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290766AbSARRtd>; Fri, 18 Jan 2002 12:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290769AbSARRtY>; Fri, 18 Jan 2002 12:49:24 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:25079 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290766AbSARRtL>;
	Fri, 18 Jan 2002 12:49:11 -0500
Date: Fri, 18 Jan 2002 10:48:46 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Christian Hammers <ch@westend.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] ext3 fs corruption with 2.4.17
Message-ID: <20020118104846.Q29178@lynx.adilger.int>
Mail-Followup-To: Christian Hammers <ch@westend.com>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020118143214.GH28471@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020118143214.GH28471@westend.com>; from ch@westend.com on Fri, Jan 18, 2002 at 03:32:14PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 18, 2002  15:32 +0100, Christian Hammers wrote:
> Does anybody knows what exactly this means and if it could be helpful to
> track down the origin of the problems? Or did anybody else experienced this
> messages before?
> 
> On Thu, Jan 17, 2002 at 07:05:03PM +0100, root wrote:
> > Jan 17 19:01:15 HOSTNAME kernel: EXT3-fs error (device sd(8,7)): ext3_new_block: Allocating block in system zone - block = 5931009
> > Jan 17 19:01:16 HOSTNAME kernel: EXT3-fs error (device sd(8,7)): ext3_new_block: Allocating block in system zone - block = 5931018
> > Jan 17 19:01:16 HOSTNAME kernel: EXT3-fs error (device sd(8,7)): ext3_new_block: Allocating block in system zone - block = 5931019
> [repeats several hundert times with increasing block numbers]

It means your block bitmap is corrupt and it says that metadata blocks
are not in use, when they really are.  That will lead to serious
corruption.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

