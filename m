Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSHIGf6>; Fri, 9 Aug 2002 02:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318167AbSHIGf6>; Fri, 9 Aug 2002 02:35:58 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:53999 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318166AbSHIGf5>; Fri, 9 Aug 2002 02:35:57 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 9 Aug 2002 00:37:25 -0600
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 journal/IDE problems ?
Message-ID: <20020809063725.GB12482@clusterfs.com>
Mail-Followup-To: Bill Huey <billh@gnuppy.monkey.org>,
	linux-kernel@vger.kernel.org
References: <20020809040456.GA786@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809040456.GA786@gnuppy.monkey.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 08, 2002  21:04 -0700, Bill Huey wrote:
> What's going on with this ?
> 
> I get:
> EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753210
> :
> :
> EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753273
> ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device ide0(3,5)) in ext3_free_blocks: Journal has aborted

Looks like you got a block of zeros from disk when it should have been a
block bitmap, or your filesystem is otherwise corrupted.  You need to do
a full fsck on this filesystem.

As for cause, I have no idea.  IDE DMA, IDE cables, memory, kernel bug...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

