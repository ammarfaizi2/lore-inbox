Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130306AbRACLHy>; Wed, 3 Jan 2001 06:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbRACLHn>; Wed, 3 Jan 2001 06:07:43 -0500
Received: from latt.if.usp.br ([143.107.129.103]:269 "HELO latt.if.usp.br")
	by vger.kernel.org with SMTP id <S130306AbRACLHj>;
	Wed, 3 Jan 2001 06:07:39 -0500
Date: Wed, 3 Jan 2001 08:37:08 -0200 (BRST)
From: "Jorge L. deLyra" <delyra@latt.if.usp.br>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
In-Reply-To: <14930.42496.545862.426153@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.3.96.1010103082044.20347B-100000@latt.if.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not a supported configuration.  You cannot export NFS mounted
> filesystems with NFS. The protocol does not cope, and it
> implementation doesn't even try.
> NFS is for export local filesystems only.

Just want to point out that this unsupported feature, which exists in the
old user-space NFS server, is very useful under some circumstances.

Case in point: you have a Beowulf-style parallel cluster on a private
network, physically connected to the Internet only through the front-end,
but with no direct routing to it, which saves addresses and security
concerns (just imagine you have 1000 nodes); you want to import on the
front-end various homes of users scattered around your lan, and then have
the front-end re-export them to the cluster on the private network.

Since the private network does not talk directly to the Internet, there is
no danger of loopback mounts locking up. This scheme makes the use of the
cluster, usually a resource shared among various groups and institutions,
very convenient for all users: their own user configs and environment are
available when they use the cluster, logging in through the front-end, and
their data goes out transparently to their home systems. Very nice!

It would be nice if a way was found to implement this feature on knfsd.

						Best regards,

----------------------------------------------------------------
        Jorge L. deLyra,  Associate Professor of Physics
            The University of Sao Paulo,  IFUSP-DFMA
       For more information: finger delyra@latt.if.usp.br
----------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
