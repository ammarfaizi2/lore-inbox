Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbVKWLoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbVKWLoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVKWLoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:44:32 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:36025
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030406AbVKWLoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:44:32 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Neil Brown <neilb@suse.de>
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
Date: Wed, 23 Nov 2005 05:43:24 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
References: <17283.52960.913712.454816@cse.unsw.edu.au>
In-Reply-To: <17283.52960.913712.454816@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511230543.24353.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 20:07, Neil Brown wrote:
> Pivot_root seems to be broken in 2.6.15-rc1-mm2.
>
> I havea initramfs filesystem, mount a ext3 filesystem (which has /mnt)
> at '/root' and
>
>   cd /root
>   pivot . mnt
>
> and it says -EINVAL.

You can't pivot_root initramfs because initramfs is rootfs.

I wrote Documentation/filesystems/ramfs-rootfs-initramfs.txt just for this 
occasion. :)

Rob
