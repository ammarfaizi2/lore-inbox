Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265633AbUFOO47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUFOO47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUFOO47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:56:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:21701 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265676AbUFOO4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:56:48 -0400
Date: Tue, 15 Jun 2004 16:56:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] stat nlink resolution fix
Message-ID: <20040615145624.GC20432@wohnheim.fh-wedel.de>
References: <20040615055507.GA9847@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615055507.GA9847@taniwha.stupidest.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 June 2004 22:55:07 -0700, Chris Wedgwood wrote:
> 
> Some filesystems can get overflows when their link-count exceeds
> 65534.  This patch increases the kernels internal resolution for this
> and also has a check for the old-system call paths to return and error
> (-EOVERFLOW) as required (as suggested by Al Viro).
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> 
> diff -Nru a/include/linux/stat.h b/include/linux/stat.h
> --- a/include/linux/stat.h	2004-06-14 17:40:21 -07:00
> +++ b/include/linux/stat.h	2004-06-14 17:40:21 -07:00
> @@ -60,7 +60,7 @@
>  	unsigned long	ino;
>  	dev_t		dev;
>  	umode_t		mode;
> -	nlink_t		nlink;
> +	unsigned int	nlink;
>  	uid_t		uid;
>  	gid_t		gid;
>  	dev_t		rdev;

Just for me to get a clue, what would break if the definition of
nlink_t changed?

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
