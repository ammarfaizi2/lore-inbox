Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSKGA4X>; Wed, 6 Nov 2002 19:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266252AbSKGA4X>; Wed, 6 Nov 2002 19:56:23 -0500
Received: from dp.samba.org ([66.70.73.150]:3031 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266250AbSKGA4W>;
	Wed, 6 Nov 2002 19:56:22 -0500
Date: Wed, 6 Nov 2002 15:41:33 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] How to flush disk cache w/read-only filesystem w/o unmount&remount? (shared SAN filesystem)
Message-ID: <20021106044133.GA15912@krispykreme>
References: <Pine.LNX.4.44.0211051014110.24422-100000@infocalypse.jimlawson.org> <20021105084218.A15258@munet-d.enel.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105084218.A15258@munet-d.enel.ucalgary.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You may be in luck - we likely need to have an ioctl to do this from
> e2fsck because the ext3 htree repacking of bad directories is causing
> a bunch of problems.  In theory, the startup scripts should reboot the
> system in this case, but there have also been cases reported where
> people ran "e2fsck -D" on an ro-mounted root and then read-write mounted
> it again.

It would be great if we could avoid the reboot, the biggest machines
I have access to can take 45 minutes to to pass firmware checks. I
hate it when fsck finds and error and causes another reboot :)

Anton
