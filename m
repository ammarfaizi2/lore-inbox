Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281189AbRKTRyB>; Tue, 20 Nov 2001 12:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281184AbRKTRv7>; Tue, 20 Nov 2001 12:51:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:20355 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S281188AbRKTRvp>; Tue, 20 Nov 2001 12:51:45 -0500
Date: Tue, 20 Nov 2001 12:40:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BFA8F87.9FB4C13E@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1011120123312.8047A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Christopher Friesen wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> > 
> > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > When a page is deleted for one executable (because we can re-read it from
> > > > on-disk binary), it is discarded, not paged out.
> > >
> > > What happens if the on-disk binary has changed since loading the program?
> > > -
> > 
> > It can't. That's the reason for `install` and other methods of changing
> > execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
> > The currently open, and possibly mapped file can be re-named, but it
> > can't be overwritten.
> 
> Actually, with NFS (and probably others) it can.  Suppose I change the file on
> the server, and it's swapped out on a client that has it mounted.  When it swaps
> back in, it can get the new information.
> 
> Chris

I note that NFS files don't currently return ETXTBSY, but this is a bug.
It is 'known' to the OS that the NFS mounted file-system is busy because
you can't unmount the file-system while an executable is running. If
you can trash it (as you can on Linux), it is surely a bug.

Alan explained a few years ago that NFS was "stateless". Nevertheless
it is still a bug.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


