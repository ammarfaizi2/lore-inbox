Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272285AbRIETQn>; Wed, 5 Sep 2001 15:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272277AbRIETQe>; Wed, 5 Sep 2001 15:16:34 -0400
Received: from [209.38.98.99] ([209.38.98.99]:21439 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S272285AbRIETQN>;
	Wed, 5 Sep 2001 15:16:13 -0400
Message-Id: <200109051916.f85JGvf11091@srvr201.castmark.com>
Content-Type: text/plain; charset=US-ASCII
From: Fred <fred@arkansaswebs.com>
To: oscarcvt@galileo.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel panic, a cry for help
Date: Wed, 5 Sep 2001 14:16:23 -0500
X-Mailer: KMail [version 1.3]
In-Reply-To: <E15efKa-0006Cj-00@the-village.bc.nu> <999707202.3b965242145d5@webmail.galileo.edu>
In-Reply-To: <999707202.3b965242145d5@webmail.galileo.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, 
try these:

first start with a ckfs of your root filesystem, that'd be:
# ckfs /dev/hdax 
for ide systems where x is usually 1-4
 or 
# ckfs /dev/sdax
for scsi systems where x is 0-6

if no troubles reported, the I'd suggest that you check some of the important 
files for sign of tampering ( /etc/passwd /etc/shadow )
if no tampering is evident, then check to see if you can boot the machine by 
giving lilo a command line (right as the machine boots, you get the lilo 
prompt (or you have to press CTRL-X to get it):

lilo: linux init=/sbin/init 

if this boots the machine, then all that is needed is to add this paramater 
to lilo.conf:

append = "init=/sbin/init"

and then rerun lilo.

if it's something else, I  need more info.
good luck
Fred

__________________________________________________ 
On Wednesday 05 September 2001 11:26 am, oscarcvt@galileo.edu wrote:
> ive started with a rescue disk, /sbin/init is present, lilo.conf seems
> fine, where might i go next?
>
> thanx to all,
> oscar
>
> > > im not sure if this q belongs here but i need all the help i can get.
> > > the www, dns, mail server at my site mysteriously got corrupted (not
> >
> > sure how).
> >
> > > Now i boot it up and get
> > >
> > > Kernel panic: No init found. Try passing init= option to kernel
> > >
> > > what can i do? where should i start? i dont want to break anything so
> >
> > please
> >
> > > help me,
> >
> > I suspect back up tapes. The kernel cannot find an /sbin/init to run
> > when
> > it starts up. That could be on of several things
> >
> > 	-	Disk failure
> > 	-	Someone broke in and erased it all
> > 	-	Misconfiguration
> >
> > A rescue disk is probably the starting point
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
