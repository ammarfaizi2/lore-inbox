Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTEEQOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTEEQOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:14:34 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:60941 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263676AbTEEQOc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:14:32 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Mike Waychison <mike@waychison.com>
Subject: Re: processes stuck in D state
Date: Mon, 5 May 2003 18:25:48 +0200
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.33.0305051122190.20491-100000@bunny.augustahouse.net>
In-Reply-To: <Pine.LNX.4.33.0305051122190.20491-100000@bunny.augustahouse.net>
Cc: Zeev Fisher <Zeev.Fisher@il.marvell.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051826.01134.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 17:24, Mike Waychison wrote:
> On Mon, 5 May 2003, Michael Buesch wrote:
> > On Monday 05 May 2003 07:52, Zeev Fisher wrote:
> > > Hi!
> >
> > Hi Zeev!
> >
> > > I got a continuos problem of unkillable processes stuck in D state (
> > > uninterruptable sleep ) on my Linux servers.
> > > It happens randomly every time on other server on another process ( all
> > > the servers are configured the same with 2.4.18-10 kernel ). Here's an
> > > example :
> >
> > [snip]
> >
> > > Has anyone noticed the same behavior ? Is this a well known problem ?
> >
> > I've had the same problem with some 2.4.21-preX twice (or maybe more
> > times, don't remember) on one of my machines.
> > IMHO it has something to do with NFS. (I'm using this box as a
> > NFS-client). I wish, I could reproduce it one more time, to do some
> > traces, etc on it. But I've not found a way to reproduce it, yet.
>
> This happens when you mount an NFS mount with the 'hard' option (default)
> and a mount's handle expires incorrectly (eg: server crash).
> Read the mount manpage for an explanation to the downsides of using
> the 'soft' option.
>
>
> Mike Waychison

my fstab-entry:
192.168.0.50:/mnt/nfs_1 /mnt/nfs_1      nfs             rw,hard,intr,user,nodev,nosuid,exec         0 0

from man mount:
[snip] The process cannot be interrupted or killed unless you also specify intr. [/snip]

I can't interrupt any process that accessed the NFS-server
while shutting down the server, although intr is specified.
_That's_ my problem. :)

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 18:23:58 up 48 min,  3 users,  load average: 1.20, 1.05, 0.93
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tpCZoxoigfggmSgRAkmdAJwM/L8mZpS+DE2WzjzrXuRdxuY98QCgin1l
aKik6/WGFwWXMjd8pjwHIXw=
=akJd
-----END PGP SIGNATURE-----

