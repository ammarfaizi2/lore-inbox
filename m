Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281019AbRKTVg0>; Tue, 20 Nov 2001 16:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKTVgQ>; Tue, 20 Nov 2001 16:36:16 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:8975 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S281000AbRKTVgF>; Tue, 20 Nov 2001 16:36:05 -0500
Message-Id: <200111202120.fAKLKit13633@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Steffen Persvold <sp@scali.no>,
        Christopher Friesen <cfriesen@nortelnetworks.com>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 15:19:45 -0600
X-Mailer: KMail [version 1.3.1]
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com> <3BFA8F87.9FB4C13E@nortelnetworks.com> <3BFAC5A1.81474E74@scali.no>
In-Reply-To: <3BFAC5A1.81474E74@scali.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 15:05, Steffen Persvold wrote:
> Christopher Friesen wrote:
> > "Richard B. Johnson" wrote:
> > > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> > > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > > When a page is deleted for one executable (because we can re-read
> > > > > it from on-disk binary), it is discarded, not paged out.
> > > >
> > > > What happens if the on-disk binary has changed since loading the
> > > > program? -
> > >
> > > It can't. That's the reason for `install` and other methods of changing
> > > execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
> > > The currently open, and possibly mapped file can be re-named, but it
> > > can't be overwritten.
> >
> > Actually, with NFS (and probably others) it can.  Suppose I change the
> > file on the server, and it's swapped out on a client that has it mounted.
> >  When it swaps back in, it can get the new information.
>
> This sounds really dangerous... What about shared libraries ??

It is.  Usually it ends with a loud 'boom' the process crashes & burns.

-Nick
