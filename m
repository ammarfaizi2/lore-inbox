Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281460AbRKFFHL>; Tue, 6 Nov 2001 00:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKFFGx>; Tue, 6 Nov 2001 00:06:53 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23996 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281462AbRKFFGr>; Tue, 6 Nov 2001 00:06:47 -0500
Date: Mon, 5 Nov 2001 22:06:22 -0700
Message-Id: <200111060506.fA656Mq18958@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun
In-Reply-To: <Pine.GSO.4.21.0110271458300.21545-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110271422520.21545-100000@weyl.math.psu.edu>
	<Pine.GSO.4.21.0110271458300.21545-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	BTW, what the hell is that?
> /*
>  * hwgraph_bdevsw_get - returns the fops of the given devfs entry.
> */
> struct file_operations * 
> hwgraph_bdevsw_get(devfs_handle_t de)
> {
>         return(devfs_get_ops(de));
> }
> 
> 	It's arch/ia64/sn/io/hcl.c.  The funny thing being, the thing
> you will get from devfs_get_ops() will _not_ be struct
> file_operations *.  And that's aside of the fact that any use of
> that function is very likely to be racy as hell.  Sigh...

Sigh indeed. I didn't write that code. Looks like someone is (ab)using
the devfs API. Contact the maintainer of that code for insight.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
