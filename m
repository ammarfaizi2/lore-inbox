Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130299AbRACLpO>; Wed, 3 Jan 2001 06:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbRACLpE>; Wed, 3 Jan 2001 06:45:04 -0500
Received: from latt.if.usp.br ([143.107.129.103]:5389 "HELO latt.if.usp.br")
	by vger.kernel.org with SMTP id <S130299AbRACLot>;
	Wed, 3 Jan 2001 06:44:49 -0500
Date: Wed, 3 Jan 2001 09:14:21 -0200 (BRST)
From: "Jorge L. deLyra" <delyra@latt.if.usp.br>
To: Andi Kleen <ak@suse.de>
cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
In-Reply-To: <20010103115236.A29799@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.3.96.1010103090203.20935A-100000@latt.if.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 3 Jan 2001 11:52:36 +0100
> From: Andi Kleen <ak@suse.de>
> To: "Jorge L. deLyra" <delyra@latt.if.usp.br>
> Cc: Neil Brown <neilb@cse.unsw.edu.au>,
>     Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
>     Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
> Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
> 
> On Wed, Jan 03, 2001 at 08:37:08AM -0200, Jorge L. deLyra wrote:
> > It would be nice if a way was found to implement this feature on knfsd.
> 
> There is: just run unfsd too, bound to an own IP address to not conflict. 

Hum, interesting, I didn't know you could run both servers at the same
time. The problem is that the old server is not being developed any more,
as dully advised on the 2.2.18 kernel help messages. In fact, we have been
having some problems with it for some time, I/O errors and mounts hanging,
mostly. In fact, upgrading to 2.2.18 broke old NFS exports in some cases
around here, until we migrated to knfsd: gave us sure-fire I/O errors and
hangs. So this might be a stopgap measure for some time, but no permanent
solution. In any case, knfsd seems so much more solid, we want to use it!

> More efficient would probably be a proxy though that just forwards packets.
> I see no reason in core NFS why multiple clients could not share a single 
> multiplexed mount. It could need some lockd support though. 

I'm afraid you lost me here... If this would have to be some kind of new
daemon or kernel module that filters out NFS packets and forwards them,
wouldn't this be equivalent to making knfsd do the same thing? Humm, on
second thoughts, maybe not, because this beast would not have to interpret
the mount as a filesystem on the front end. Am I following you correctly?

----------------------------------------------------------------
        Jorge L. deLyra,  Associate Professor of Physics
            The University of Sao Paulo,  IFUSP-DFMA
       For more information: finger delyra@latt.if.usp.br
----------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
