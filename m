Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314051AbSEIRnC>; Thu, 9 May 2002 13:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSEIRnB>; Thu, 9 May 2002 13:43:01 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:25749 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S314051AbSEIRnB>; Thu, 9 May 2002 13:43:01 -0400
Message-ID: <3CDAB443.7F5E3B27@us.ibm.com>
Date: Thu, 09 May 2002 12:39:15 -0500
From: Andrew Theurer <habanero@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
In-Reply-To: <20020508140124.79124.qmail@web12408.mail.yahoo.com> <87znzawpk9.fsf@ceramic.fifi.org> <3CD9B44F.4A023A70@mvista.com> <200205091111.g49BBQX25905@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Denis Vlasenko wrote:
> 
> On 8 May 2002 21:27, george anzinger wrote:
> > > > >  Is there any way i can kill a task in
> > > > > TASK_UNINTERRUPTIBLE state ?
> > > > No. Everytime you see hung task in this state
> > > > you see kernel bug.
> > > > Somebody correct me if I am wrong.
> > >
> > > Except for processes accessing NFS files while the NFS server is down:
> > > they will be stuck in TASK_UNINTERRUPTIBLE until the NFS server comes
> > > back up again.
> >
> > A REALLY good argument for puting timeouts on your NSF mounts!  Don't
> > leave home without them.
> 
> Timeouts may be a bad idea: imagine large (LARGE) database
> which you don't want to repair due to lost data over NFS.
> Better let it hang in NFS i/o even for hours while you are
> repairing your network.

I'm not sure using an NFS mount for a big important DB would be prudent
in the first place.  I dunno, maybe there are situations where it's
unavoidable.  I just really cringe when hearing about DB volumes over
NFS.

-Andrew
