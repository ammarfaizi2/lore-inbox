Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288594AbSAOQyY>; Tue, 15 Jan 2002 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSAOQyP>; Tue, 15 Jan 2002 11:54:15 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:62909 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288594AbSAOQyC>; Tue, 15 Jan 2002 11:54:02 -0500
Date: Tue, 15 Jan 2002 09:53:47 -0700
Message-Id: <200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche writes:
> --=-=-=
> 
> Hi,
> 
> this is a new file system to control access to system resources.
> Currently it controls access to inet_bind() with ports < 1024 only.
> 
> With this patch, there's no need anymore to run internet daemons as
> root. You can individually configure which user/program can bind to
> ports below 1024.
> 
> For example, you can say, user www is allowed to bind to port 80 or
> user mail is allowed to bind to port 25. Then, you can run apache as
> user www and sendmail as user mail. Now, you don't have to rely on
> apache or sendmail giving up superuser rights to enhance security.
> 
> To use this, you need to mount the file system and do a chown on the
> appropriate ports:
> 
> # mount -t accessfs none /mnt
> # chown www /mnt/net/ipv4/bind/80
> # chown mail /mnt/net/ipv4/bind/25

Having to set the permissions like this on each boot seems a bit
painful. Why not have permissions persistence like devfs has?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
