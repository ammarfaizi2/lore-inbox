Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135386AbRDRVvj>; Wed, 18 Apr 2001 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135389AbRDRVvT>; Wed, 18 Apr 2001 17:51:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41715 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135386AbRDRVvK>;
	Wed, 18 Apr 2001 17:51:10 -0400
Date: Wed, 18 Apr 2001 17:51:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc_mknod() should check the mode parameter
In-Reply-To: <20010418222826.N6985@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.GSO.4.21.0104181749060.15153-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2001, Erik Mouw wrote:

> Hi all,
> 
> While documenting the procfs interface (more of that later), I came
> across proc_mknod() which is supposed to be used to create devices in
> the procfs. IMHO it should therefore check if the mode parameter
> contains S_IFBLK or S_IFCHR.

Why? All callers of proc_mknod() are in the kernel and they should
know better. I could understand
	if (....)
		BUG();
but silently doing nothing is really odd.

