Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbTIGJDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 05:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTIGJDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 05:03:18 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:24313 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262915AbTIGJDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 05:03:17 -0400
Date: Sun, 7 Sep 2003 03:02:24 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Aaron Dewell <acd@woods.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: partition recovery question resolution
Message-ID: <20030907030224.B18482@schatzie.adilger.int>
Mail-Followup-To: Aaron Dewell <acd@woods.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309062335230.20670-100000@dragon.woods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309062335230.20670-100000@dragon.woods.net>; from acd@woods.net on Sat, Sep 06, 2003 at 11:43:17PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 06, 2003  23:43 -0600, Aaron Dewell wrote:
> Doing a dd back to the disk with a short file shouldn't
> affect anything past the end of the file, right?  Therefore, there would have
> had to have been some kind of condition whereby the file got truncated while a
> dd was going on, and for some reason, it started writing zeros instead of
> stopping.

That's a common pitfall of dd.  It will truncate regular output files unless
you use "conv=notrunc".  If you are writing to a block device it obviously
can't truncate the device so you don't notice it unless you are trying to
dd over an existing file.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

