Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSLBXKM>; Mon, 2 Dec 2002 18:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSLBXKL>; Mon, 2 Dec 2002 18:10:11 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:44026 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S265130AbSLBXKK>; Mon, 2 Dec 2002 18:10:10 -0500
Date: Mon, 2 Dec 2002 16:14:16 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More intellegent bad block reallocation in software?
Message-ID: <20021202161416.L1422@schatzie.adilger.int>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	linux-kernel@vger.kernel.org
References: <200212022320.gB2NKS2J000315@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212022320.gB2NKS2J000315@darkstar.example.net>; from john@grabjohn.com on Mon, Dec 02, 2002 at 11:20:28PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 02, 2002  23:20 +0000, John Bradford wrote:
> My idea is that we could allocate one block out of every ten to be a
> spare block, (which would reduce disk capacity by 10%), and then if a
> block needed to be re-allocated, we could allocate one from the same
> cylinder, therefore removing the need for the heads to seek across the
> disk.
> 
> How easily could this be added to existing filesystems?  Presumably
> we'd need extra functionality in both filesystem code and the IDE and
> SCSI code, and I realise that it might be completely impossible,
> without custom firmware on the disk.  It's an interesting idea
> though.

Even better - just ignore bad blocks and don't relocate them at all.
That's what ext2/3 do - just skip those blocks and avoid the seek
entirely.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

