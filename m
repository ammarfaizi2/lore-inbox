Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280130AbRKXVMe>; Sat, 24 Nov 2001 16:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280153AbRKXVMY>; Sat, 24 Nov 2001 16:12:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41234 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280130AbRKXVMO>; Sat, 24 Nov 2001 16:12:14 -0500
Date: Sat, 24 Nov 2001 17:54:51 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Marc A. Ohmann" <marc@ds6.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <20011124150905.A26221@flanders.digsol.net>
Message-ID: <Pine.LNX.4.21.0111241752470.12149-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Marc A. Ohmann wrote:

> > Hi,
> > 
> > So here it goes 2.4.16-pre1. Obviously the most important fix is the
> > iput() one, which probably fixes the filesystem corruption problem people
> > have been seeing.
> > 
> > Please, people who have been experiencing the fs corruption problems test
> > this and tell me its now working so I can release a final 2.4.16 ASAP.
> > 
> > 
> > - Correctly sync inodes in iput()			(Alexander Viro)
> > - Make pagecache readahead size tunable via /proc	(was in -ac tree)
> > - Fix PPC kernel compilation problems			(Paul Mackerras)
> 
> I build Andrea's patch and everything seemed to work fine.  I am building 2.4.16-pre1 on two systems right now.  


> What can I check to test the iput() patch or any other patches?

To test the iput() patch do some filesystem activity (with lots of files),
reboot the machine, and check if your fs is still sane after that.

The other patches you can't really test I guess: one is for PPC, the other
one is known to work correctly.

