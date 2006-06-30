Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWF3HqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWF3HqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWF3HqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:46:00 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:34194 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751356AbWF3Hp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:45:59 -0400
Date: Fri, 30 Jun 2006 01:45:58 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: cmm@us.ibm.com, jitendra@linsyssoft.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [RFC][PATCH]add ext3_fileblk_t for file relative offset
Message-ID: <20060630074558.GP5318@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp, cmm@us.ibm.com,
	jitendra@linsyssoft.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <20060628223109sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628223109sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2006  22:31 +0900, sho@tnes.nec.co.jp wrote:
> In Mingming's patch set, the single type `ext3_fsblk_t' deal with two
> different values, which are file relative offset and filesystem
> relative offset.  I think it is confusing.
> 
> Therefore I added "ext3_fileblk_t" for file relative offset.
> It makes maintenance easier and code clearer if file size
> needs to be larger.
> ext3_fileblk_t is unsigned long which is the maximum size of
> current type for file relative offset.

I think this is a good idea and support its inclusion into the patch set.
It also managed to find one (harmless) bug in the code.
 
>  int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,
> -		sector_t iblock, unsigned long maxblocks,
> +		ext3_fileblk_t iblock, unsigned long maxblocks,

iblock shouldn't have been a sector_t.


Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

