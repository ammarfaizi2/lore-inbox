Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144991AbRA2Cux>; Sun, 28 Jan 2001 21:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144997AbRA2Cun>; Sun, 28 Jan 2001 21:50:43 -0500
Received: from ir.com.au ([210.8.187.18]:3021 "EHLO ir_nt_server2.ir.com.au")
	by vger.kernel.org with ESMTP id <S144991AbRA2Cub>;
	Sun, 28 Jan 2001 21:50:31 -0500
Message-ID: <C0D2F5944500D411AD8A00104B31930E10809C@ir_nt_server2>
From: Tony.Young@ir.com
To: chris@scary.beasts.org
Cc: slug@slug.org.au, csa@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: RE: Linux Disk Performance/File IO per process
Date: Mon, 29 Jan 2001 13:50:26 +1100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Chris Evans [mailto:chris@scary.beasts.org]
> Sent: Monday, 29 January 2001 13:04
> To: Tony Young
> Cc: slug@slug.org.au; csa@oss.sgi.com; linux-kernel@vger.kernel.org
> Subject: Re: Linux Disk Performance/File IO per process
> 
> 
> 
> On Mon, 29 Jan 2001 Tony.Young@ir.com wrote:
> 
> > All,
> >
> > I work for a company that develops a systems and 
> performance management
> > product for Unix (as well as PC and TANDEM) called 
> PROGNOSIS. Currently we
> > support AIX, HP, Solaris, UnixWare, IRIX, and Linux.
> >
> > I've hit a bit of a wall trying to expand the data provided 
> by our Linux
> > solution - I can't seem to find anywhere that provides the 
> metrics needed to
> > calculate disk busy in the kernel! This is a major piece of 
> information that
> > any mission critical system administrator needs to 
> successfully monitor
> > their systems.
> 
> Stephen Tweedie has a rather funky i/o stats enhancement patch which
> should provide what you need. It comes with RedHat7.0 and gives decent
> disk statistics in /proc/partitions.
> 
> Unfortunately this patch is not yet in the 2.2 or 2.4 kernel. 
> I'd like to
> see it make the kernel as a 2.4.x item. Failing that, it'll 
> probably make
> the 2.5 kernel.
> 
> Cheers
> Chris
>

Thanks to both Jens and Chris - this provides the information I need to
obtain our busy rate
It's unfortunate that the kernel needs to be patched to provide this
information - hopefully it will become part of the kernel soon.

I had a response saying that this shouldn't become part of the kernel due to
the performance cost that obtaining such data will involve. I agree that a
cost is involved here, however I think it's up to the user to decide which
cost is more expensive to them - getting the data, or not being able to see
how busy their disks are. My feeling here is that this support could be user
configurable at run time - eg 'cat 1 > /proc/getdiskperf'.

Thanks for your quick responses.

Tony...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
