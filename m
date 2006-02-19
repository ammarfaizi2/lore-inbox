Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWBSVan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWBSVan (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWBSVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:30:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55691 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750830AbWBSVaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:30:23 -0500
Date: Mon, 20 Feb 2006 08:29:46 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060220082946.A9478997@wobbly.melbourne.sgi.com>
References: <20060216183629.GA5672@skyscraper.unix9.prv> <20060217063157.B9349752@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Fri, Feb 17, 2006 at 05:54:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 05:54:49PM +0100, Jan Engelhardt wrote:
> >> XFS mounting filesystem hda3
> >> Starting XFS recovery on filesystem: hda3 (logdev: internal)
> >> EIP:    0060:[xlog_recover_do_inode_trans+473/2688]    Tainted: P      VLI
> >
> >This indicates you are running recovery - run xfs_repair first
> >if you know the filesystem is corrupt.
> >
> How does one know a filesystem got "corrupt enough" to require xfs_repair 
> first?

Any corruption should be repaired.  You'd notice corruption by
either running repair (as the bug reporter here had asserted),
or via the filesystem shutting down when the ondisk corruption
was encountered.

cheers.

-- 
Nathan
