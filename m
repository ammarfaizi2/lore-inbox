Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbUKQS4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUKQS4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUKQSxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:53:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262491AbUKQSxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:53:07 -0500
Date: Wed, 17 Nov 2004 18:53:05 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041117185305.GF26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu> <16795.33515.187015.492860@thebsh.namesys.com> <Pine.LNX.4.53.0411171809490.24190@yvahk01.tjqt.qr> <16795.35688.634029.21478@gargle.gargle.HOWL> <Pine.LNX.4.53.0411171837250.15704@yvahk01.tjqt.qr> <16795.37202.793499.93514@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16795.37202.793499.93514@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 08:58:42PM +0300, Nikita Danilov wrote:
> "mount-table" (fs/namespace.c:mount_hashtable) is consulted only when
> path-resolution crosses dentry marked as mount-point (has non-zero
> ->d_mounted field), which is rare, and this means that number of
> elements in mount_hashtable has little effect on the cost of path-name
> resolution.

Not to mention the fact that hash chains there are considerably
shorter than those in dcache.  I would be _very_ surprised if loop in
lookup_mnt() would become a hotspot in profiles.
