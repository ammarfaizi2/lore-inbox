Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSEILPL>; Thu, 9 May 2002 07:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315695AbSEILPK>; Thu, 9 May 2002 07:15:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26884 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312449AbSEILPK>; Thu, 9 May 2002 07:15:10 -0400
Message-Id: <200205091111.g49BBQX25905@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: george anzinger <george@mvista.com>, Philippe Troin <phil@fifi.org>
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
Date: Thu, 9 May 2002 13:18:20 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Amol Lad <dal_loma@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020508140124.79124.qmail@web12408.mail.yahoo.com> <87znzawpk9.fsf@ceramic.fifi.org> <3CD9B44F.4A023A70@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2002 21:27, george anzinger wrote:
> > > >  Is there any way i can kill a task in
> > > > TASK_UNINTERRUPTIBLE state ?
> > > No. Everytime you see hung task in this state
> > > you see kernel bug.
> > > Somebody correct me if I am wrong.
> >
> > Except for processes accessing NFS files while the NFS server is down:
> > they will be stuck in TASK_UNINTERRUPTIBLE until the NFS server comes
> > back up again.
>
> A REALLY good argument for puting timeouts on your NSF mounts!  Don't
> leave home without them.

Timeouts may be a bad idea: imagine large (LARGE) database
which you don't want to repair due to lost data over NFS.
Better let it hang in NFS i/o even for hours while you are
repairing your network.

OTOH, interruptible NFS mounts are ok: processes can be killed but
with explicit admin action only, just what I need.

Anybody uses _uninterruptible_ NFS mounts? Enlighten me why.
--
vda
