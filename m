Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTKKDwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTKKDwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:52:22 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:4079 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264241AbTKKDwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:52:19 -0500
Date: Mon, 10 Nov 2003 20:50:12 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davide.rossetti@roma1.infn.it, filia@softhome.net,
       jesse@cats-chateau.net, dwmw2@infradead.org, moje@vabo.cz,
       kakadu_croc@yahoo.com
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031110205011.R10197@schatzie.adilger.int>
Mail-Followup-To: Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	davide.rossetti@roma1.infn.it, filia@softhome.net,
	jesse@cats-chateau.net, dwmw2@infradead.org, moje@vabo.cz,
	kakadu_croc@yahoo.com
References: <1068512710.722.161.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1068512710.722.161.camel@cube>; from albert@users.sourceforge.net on Mon, Nov 10, 2003 at 08:05:11PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2003  20:05 -0500, Albert Cahalan wrote:
> > It is too simple to implement in user mode.
> 
> That works for a plain byte-stream on a
> local UNIX-style filesystem. (though it
> likely isn't the fastest)
> 
> It doesn't work for Macintosh files.
> It's too slow for CIFS over a modem.
> It doesn't work for Windows security data.
> It doesn't allow copy-on-write files.
> It eats CPU time on compressed filesystems.

Having a sys_copy() syscall would be incredibly useful for Lustre
(distributed Linux fs).  We could start a copy from one storage node
to another (or more likely many to many for a file striped over many
storage nodes) at num_stripes * uni-directional bandwidth with no
impact to the client node.  Instead, we have to copy files at best a
single client's bi-directional network_bandwidth.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

