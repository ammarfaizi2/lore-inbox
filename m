Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281463AbRKTXXj>; Tue, 20 Nov 2001 18:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281487AbRKTXXY>; Tue, 20 Nov 2001 18:23:24 -0500
Received: from Expansa.sns.it ([192.167.206.189]:52745 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S281463AbRKTXWU>;
	Tue, 20 Nov 2001 18:22:20 -0500
Date: Wed, 21 Nov 2001 00:20:49 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <Pine.LNX.3.95.1011120123312.8047A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0111210019590.7168-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Nov 2001, Richard B. Johnson wrote:

> On Tue, 20 Nov 2001, Christopher Friesen wrote:
>
> > "Richard B. Johnson" wrote:
> > >
> > > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> > >
> > > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > > When a page is deleted for one executable (because we can re-read it from
> > > > > on-disk binary), it is discarded, not paged out.
> > > >
> > > > What happens if the on-disk binary has changed since loading the program?
> > > > -
> > >
> > > It can't. That's the reason for `install` and other methods of changing
> > > execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
> > > The currently open, and possibly mapped file can be re-named, but it
> > > can't be overwritten.
> >
> > Actually, with NFS (and probably others) it can.  Suppose I change the file on
> > the server, and it's swapped out on a client that has it mounted.  When it swaps
> > back in, it can get the new information.
> >
> > Chris
>
> I note that NFS files don't currently return ETXTBSY, but this is a bug.
> It is 'known' to the OS that the NFS mounted file-system is busy because
> you can't unmount the file-system while an executable is running. If
> you can trash it (as you can on Linux), it is surely a bug.
>
In most of the cases, the process on the client simply dies....



