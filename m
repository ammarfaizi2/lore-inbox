Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314065AbSEISAt>; Thu, 9 May 2002 14:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSEISAs>; Thu, 9 May 2002 14:00:48 -0400
Received: from sendmail.avnet.com ([12.9.139.96]:9847 "EHLO pilsner.avnet.com")
	by vger.kernel.org with ESMTP id <S314065AbSEISAs>;
	Thu, 9 May 2002 14:00:48 -0400
Message-ID: <C08678384BE7D311B4D70004ACA371050B763462@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Andrew Theurer'" <habanero@us.ibm.com>,
        vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: RE: kill task in TASK_UNINTERRUPTIBLE
Date: Thu, 9 May 2002 11:00:29 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please, this could turn into a flamewar:

*	Users hate the NFS hangs.
*	Applications need them for consistency.

Is there really a solution that makes everyone happy
when NFS servers are down?  If so, I haven't seen it
in my career working with NFS.  (Unless NFS v3 helps ...)
All the network admins I've known choose non-interruptible,
tolerate the complaining users when a server is down,
and just work on getting the server back on-line ASAP.

> -----Original Message-----
> From: Andrew Theurer [mailto:habanero@us.ibm.com]
> Sent: Thursday, May 09, 2002 10:39 AM
> To: vda@port.imtp.ilyichevsk.odessa.ua
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: kill task in TASK_UNINTERRUPTIBLE
> 
> 
> 
> 
> Denis Vlasenko wrote:
> > 
> > On 8 May 2002 21:27, george anzinger wrote:
> > > > > >  Is there any way i can kill a task in
> > > > > > TASK_UNINTERRUPTIBLE state ?
> > > > > No. Everytime you see hung task in this state
> > > > > you see kernel bug.
> > > > > Somebody correct me if I am wrong.
> > > >
> > > > Except for processes accessing NFS files while the NFS 
> server is down:
> > > > they will be stuck in TASK_UNINTERRUPTIBLE until the 
> NFS server comes
> > > > back up again.
> > >
> > > A REALLY good argument for puting timeouts on your NSF 
> mounts!  Don't
> > > leave home without them.
> > 
> > Timeouts may be a bad idea: imagine large (LARGE) database
> > which you don't want to repair due to lost data over NFS.
> > Better let it hang in NFS i/o even for hours while you are
> > repairing your network.
> 
> I'm not sure using an NFS mount for a big important DB would 
> be prudent
> in the first place.  I dunno, maybe there are situations where it's
> unavoidable.  I just really cringe when hearing about DB volumes over
> NFS.
> 
> -Andrew
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
