Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281921AbRKUQtA>; Wed, 21 Nov 2001 11:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281917AbRKUQsv>; Wed, 21 Nov 2001 11:48:51 -0500
Received: from mta.sara.nl ([145.100.16.144]:33431 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S281451AbRKUQsg>;
	Wed, 21 Nov 2001 11:48:36 -0500
Message-Id: <200111211648.RAA26705@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: Steffen Persvold <sp@scali.no>
cc: Christopher Friesen <cfriesen@nortelnetworks.com>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Swap 
In-Reply-To: Message from Steffen Persvold <sp@scali.no> 
   of "Tue, 20 Nov 2001 22:05:37 +0100." <3BFAC5A1.81474E74@scali.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Nov 2001 17:48:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Christopher Friesen wrote:
> > 
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
> 
> This sounds really dangerous... What about shared libraries ??
> 

Same problem. This is why most Unix distros tell you to reboot after each 
patch applied and each OS upgrade. just to be sure that all mmapped files and 
page-demand loaded bins are all restarted.


-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


