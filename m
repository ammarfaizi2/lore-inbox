Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbRENXjh>; Mon, 14 May 2001 19:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262583AbRENXj1>; Mon, 14 May 2001 19:39:27 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:1946 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262582AbRENXjX>; Mon, 14 May 2001 19:39:23 -0400
Date: Mon, 14 May 2001 17:39:09 -0600
Message-Id: <200105142339.f4ENd9t19497@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro), hpa@transmeta.com (H. Peter Anvin),
        torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zRIW-0001dr-00@the-village.bc.nu>
In-Reply-To: <Pine.GSO.4.21.0105141856090.19333-100000@weyl.math.psu.edu>
	<E14zRIW-0001dr-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Oh, _that_ one. <shrug> pass rootname=driver!name (or whatever syntax
> > you prefer) to the kernel and call do_mount() instead of sys_mknod() in
> > prepare_namespace() (rootfs patch). BFD.
> 
> Yet another 2.5 project. If Linus wants to go play with name driven
> devices and you want to help him great, but if he'd care to put out
> linux-2.5.0.tar.gz _before_ starting that would be good for all of
> us

I use LILO and I pass a devfs name for the ROOT fs. You just need to
pass the name as a string. If you type it at the LILO prompt, it gets
passed as a string (and thus devfs will use it to descend the tree).
Also, you can put in /etc/lilo.conf:
	append = "root=/dev/scsi/host0/bus0/target0/lun0/part2"

and it will pass the string. Works nicely.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
