Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281288AbRKPKdq>; Fri, 16 Nov 2001 05:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281286AbRKPKdh>; Fri, 16 Nov 2001 05:33:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31721 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281284AbRKPKdW>;
	Fri, 16 Nov 2001 05:33:22 -0500
Date: Fri, 16 Nov 2001 05:33:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0111160528020.5234-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Nov 2001, Neil Brown wrote:

> +	if (!(nd->mnt->mnt_flags & MNT_NODEV)
> +	    && dentry->d_inode
> +	    && (dentry->d_inode->i_mode & S_ISVTX)) {
> +		dentry = devlink_find(dentry, link);

You are breaking vfsmount refcounting.  Badly.

