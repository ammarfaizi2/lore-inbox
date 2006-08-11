Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWHKS3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWHKS3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHKS3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:29:44 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:58845 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1750889AbWHKS3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:29:44 -0400
Date: Fri, 11 Aug 2006 20:29:38 +0200
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: xfs@oss.sgi.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Directory corruption
Message-ID: <20060811182938.GA14761@pc51072.physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
References: <Pine.LNX.4.61.0608111955530.23379@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608111955530.23379@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 08:00:08PM +0200, Jan Engelhardt wrote:
> Hello,
> 
> 
> I was about to (finally!) fix my on-disk corruptions using a new xfsprogs, 
> and this is what I got:
> 
> # xfs_check /dev/hda2
> bad free block nused 1 should be 40 for dir ino 17332222 block 16777216
> bad nblocks 907 for inode 109663513, counted 922
> bad nblocks 849 for inode 109663521, counted 859
> sb_ifree 26084, counted 26080
> sb_fdblocks 1712799, counted 1712761
> user quota id 0, have/exp bc 796381/796369
> group quota id 0, have/exp bc 794376/794364 ic 88214/88212
> group quota id 5, have/exp ic 651/653
> 
> But before I wanted to fix that, I checked which objects were affected
> 
> # find /mnt/hda2ro -inum 109663513 -o -inum 109663521
> /mnt/hda2ro/var/log/kernel
> /mnt/hda2ro/var/log/messages
> Ok so far, but
> 
> # find /mnt/hda2ro -inum 17332222
> 
> Did not turn up anything. Is it an object that is invisible?
>
what does 'xfs_ncheck -i 17332222 /dev/hda2' tell ?

cheers.
 - Christian

