Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSCHXvP>; Fri, 8 Mar 2002 18:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSCHXvG>; Fri, 8 Mar 2002 18:51:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12735 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291314AbSCHXu6>;
	Fri, 8 Mar 2002 18:50:58 -0500
Date: Fri, 8 Mar 2002 18:50:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug in set_fs_altroot()
In-Reply-To: <E16jPBF-0006qL-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0203081849570.2248-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Mar 2002, Paul Menage wrote:

> 
> There's a missing '!' in set_fs_altroot():

Sigh...  That was not my week ;-/

Linus, please apply.
 
> --- linux-2.5.6/fs/namei.c~	Fri Mar  8 10:21:38 2002
> +++ linux-2.5.6/fs/namei.c	Fri Mar  8 10:26:36 2002
> @@ -761,7 +761,7 @@
>  	if (!emul)
>  		goto set_it;
>  	err = path_lookup(emul, LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);
> -	if (err) {
> +	if (!err) {
>  		mnt = nd.mnt;
>  		dentry = nd.dentry;
>  	}
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

