Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEQUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEQUHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUEQUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:07:53 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:52610 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261205AbUEQUHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:07:52 -0400
Date: Mon, 17 May 2004 14:07:48 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: felix-kernel@fefe.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.5, ext3] getdents reports files that stat says aren't there
Message-ID: <20040517200748.GJ18086@schnapps.adilger.int>
Mail-Followup-To: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
References: <20040517193954.GA14835@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517193954.GA14835@codeblau.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 17, 2004  21:39 +0200, felix-kernel@fefe.de wrote:
> I keep getting this effect on my ext3 file system.
> Applications like ls call readdir, get long deleted files, then stat
> them, and get ENOENT.
> 
> Most applications can handle this, but some report ugly errors or
> warnings.  I wonder: why does getdents report entries of deleted files?
> I ran e2fsck on the partition, but it found nothing.  So I guess it's
> not a file system error.  I have been seeing this for months now.  It
> does not actually hurt a lot, but I think it should be fixed
> nonetheless.

Are you using htree/indexed directories?

dumpe2fs -h /dev/XXX | grep dir_index

will tell you.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

