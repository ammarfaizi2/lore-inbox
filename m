Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287374AbSACQSS>; Thu, 3 Jan 2002 11:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287379AbSACQSJ>; Thu, 3 Jan 2002 11:18:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41858 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287374AbSACQSB>;
	Thu, 3 Jan 2002 11:18:01 -0500
Date: Thu, 3 Jan 2002 11:17:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Oleg Drokin <green@namesys.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] expanding truncate
In-Reply-To: <20020103152520.A7030@namesys.com>
Message-ID: <Pine.GSO.4.21.0201031111130.23312-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Oleg Drokin wrote:

> Purpose of this patch is of course not to fill in the datablocks with zeroes.
> The purpose (as applied to reiserfs) is to fill indirect data pointers (that is - pointers to real data blocks)
> with zeroes (and to organize proper in-tree data structure for such pointers).
> As of now such organization and zero-filling is done on a lazy manner at disk-flushing time.
> Unfortunatelly this leads to races in the code.
> I do not know why parts of this code can be needed by other filesystem and why Al Viro put it in generic VFS
> code. (but he can comment on it, I think)

I could, if I would remember doing that... ;-/

	Seriously, it looks like a half-arsed and very old attempt to do common
expanding truncate() for no-holes filesystems.  BTW, these days rlimit checks
are done by vmtruncate().


