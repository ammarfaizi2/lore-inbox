Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUE0BA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUE0BA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 21:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUE0BA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 21:00:28 -0400
Received: from main.gmane.org ([80.91.224.249]:58851 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261468AbUE0BA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 21:00:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Calvin Spealman <calvin@ironfroggy.com>
Subject: Re: Filesystem space accounting bug
Date: Wed, 26 May 2004 07:38:24 +0000
Message-ID: <1983750.MKsGDOebfy@ironfroggy.com>
References: <20040525150512.GE7195@secretlab.mine.nu>
Reply-To: calvin@ironfroggy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-069-132-046-251.carolina.rr.com
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similar problem a few days ago. My wife was working in GIMP and
called me in, complaining about an Out Of Space error. I didn't find it out
of the ordinary, so I removed lots of temp files and tarballs of things
already installed. I cleared up a few gigs.

A few hours later, she got the same errors. I deleted all the videos I
already had backed-up on CD, since my DVD player can play those anyway.

A few hours later, she got the same errors. I knew at this point something
weird was going on. A few friends suggested my system had been compromised,
but I knew better. Eventually I tried rebooting to a Live CD, so I could
run fsck.ext3, but everything now looked fine. I haven't had the problem
since, and I have no idea what caused it.

Walter Hofmann wrote:

> Hi,
> 
> I have a backup script which creates a filesystem image which is later
> written to DVD. It is created & loop-mounted with
> 
>  dd if=/dev/zero of=${DARIMAGE} bs=1024k count=4460 || exit 1
>  mke2fs -F -b 4096 -m 0 -N 32 -O sparse_super -L BACKUP ${DARIMAGE} ||
>  exit 1 sync
>  mount /mnt/dar
>  touch /mnt/dar/backup-stamp
> 
> Then I use the "dar" utility to create a single large file on this. I
> believe, but have not checked, that dar writes the file linearly. dar is
> instructed to stop writing to the filesystem before it reaches 4GB.
> 
> However, recently, dar failed after approx. 3GB with ENOSPC. The
> filesystem was still mounted, so I could check that there really were
> only 3GB written to it. Still, I could not even create a 1 byte file on
> it, although there should be around 1GB free space left.
> 
> There were no error messages logged. I unmounted the image and ran
> e2fsck on it and it reported that the free block count in a number of
> groups on the filesystem was wrong.
> 
> I'm using Linux 2.6.6. I tried to reproduce this, but now it works
> again.
> 
> Walter

-- 
 

