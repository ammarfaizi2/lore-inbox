Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTEEPN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 11:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTEEPN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 11:13:56 -0400
Received: from CPE0010e000064f-CM014270111571.cpe.net.cable.rogers.com ([65.49.101.0]:60742
	"EHLO bunny.augustahouse.net") by vger.kernel.org with ESMTP
	id S262362AbTEEPNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 11:13:53 -0400
Date: Mon, 5 May 2003 11:24:18 -0400 (EDT)
From: Mike Waychison <mike@waychison.com>
X-X-Sender: <mike@bunny.augustahouse.net>
To: Michael Buesch <fsdeveloper@yahoo.de>
cc: Zeev Fisher <Zeev.Fisher@il.marvell.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: processes stuck in D state
In-Reply-To: <200305051656.32048.fsdeveloper@yahoo.de>
Message-ID: <Pine.LNX.4.33.0305051122190.20491-100000@bunny.augustahouse.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 May 2003, Michael Buesch wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Monday 05 May 2003 07:52, Zeev Fisher wrote:
> > Hi!
>
> Hi Zeev!
>
> > I got a continuos problem of unkillable processes stuck in D state (
> > uninterruptable sleep ) on my Linux servers.
> > It happens randomly every time on other server on another process ( all
> > the servers are configured the same with 2.4.18-10 kernel ). Here's an
> > example :
> [snip]
> > Has anyone noticed the same behavior ? Is this a well known problem ?
>
> I've had the same problem with some 2.4.21-preX twice (or maybe more times,
> don't remember) on one of my machines.
> IMHO it has something to do with NFS. (I'm using this box as a NFS-client).
> I wish, I could reproduce it one more time, to do some traces, etc
> on it. But I've not found a way to reproduce it, yet.
>

This happens when you mount an NFS mount with the 'hard' option (default)
and a mount's handle expires incorrectly (eg: server crash).
Read the mount manpage for an explanation to the downsides of using
the 'soft' option.


Mike Waychison

> - --
> Regards Michael Büsch
> http://www.8ung.at/tuxsoft
>  16:50:44 up 52 min,  1 user,  load average: 1.00, 1.00, 0.94
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
>
> iD8DBQE+tnugoxoigfggmSgRAt8BAJ0deufnL/E6acpz4pIPZll8f48TIgCfWmcI
> auSRmi6oyrTbqMVe+MrfuV4=
> =ahIZ
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

