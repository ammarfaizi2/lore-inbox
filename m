Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284938AbRLKJNe>; Tue, 11 Dec 2001 04:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284942AbRLKJNX>; Tue, 11 Dec 2001 04:13:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32900 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284938AbRLKJNK>;
	Tue, 11 Dec 2001 04:13:10 -0500
Date: Tue, 11 Dec 2001 04:13:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: GOTO Masanori <gotom@debian.org>
cc: torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <w534rmynn77.wl@megaela.fe.dis.titech.ac.jp>
Message-ID: <Pine.GSO.4.21.0112110411540.16630-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Dec 2001, GOTO Masanori wrote:

> +	/*
> +	 * If inode is BLK and it is not already mounted,
> +	 * blocksize change hardsect_size.
> +	 */
> +	if (S_ISBLK(inode->i_mode) && !is_mounted(inode->i_rdev)) {


That's obviously wrong.  What's to stop it from getting mounted
right after that check?

