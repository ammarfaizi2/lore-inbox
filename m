Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281918AbRKUQpK>; Wed, 21 Nov 2001 11:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281917AbRKUQpB>; Wed, 21 Nov 2001 11:45:01 -0500
Received: from mta.sara.nl ([145.100.16.144]:20631 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S281451AbRKUQow>;
	Wed, 21 Nov 2001 11:44:52 -0500
Message-Id: <200111211644.RAA26269@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: root@chaos.analogic.com
cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap 
In-Reply-To: Message from "Richard B. Johnson" <root@chaos.analogic.com> 
   of "Tue, 20 Nov 2001 12:40:58 EST." <Pine.LNX.3.95.1011120123312.8047A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Nov 2001 17:44:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Alan explained a few years ago that NFS was "stateless". Nevertheless
> it is still a bug.
> 
> Cheers,
> Dick Johnson
> 

The Client OS knows the fs is busy, the server does not, so from the server 
side, I can change a file, unmount parts of the exported fs (nfs does not see 
fs boudries), or even mount a completely different fs on the exported fs, 
breaking the nfs client and the nfs server. Been there, done that. Yes, this 
is not userfriendly, but then again, NFS in not the best networked filesystem 
in the world, not was it designed to be handled by non-administrators.  (and I 
think it shouldn't have to be).


-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams



