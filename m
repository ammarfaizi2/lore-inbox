Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTEUR0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 13:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbTEUR0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 13:26:30 -0400
Received: from [208.186.192.194] ([208.186.192.194]:9421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262219AbTEUR02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 13:26:28 -0400
Message-Id: <200305211739.h4LHdRI04558@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org
Subject: Re: re-aim - 2.5.69, -mm6 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Wed, 21 May 2003 09:25:36 PDT." <20030521092536.1e04edd1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 May 2003 10:39:27 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White <cliffw@osdl.org> wrote:
> >
> > The two runs are done like this -> (4 cpu machine)
> >  ./reaim -s4 -x -t -i4 -f workfile.new_dbase -r3 -b -lstp.config -> for the 
> >  maxjobs convergence
> >  ./reaim -s4 -q -t -i4 -f workfile.new_dbase -r3 -b -lstp.config -> for the 
> >  'quick' convergence
> > 
> >  stp.config has the poolsizes and path for disk directories:
> >  FILESIZE 80k
> >  POOLSIZE 1024k
> >  DISKDIR /mnt/disk1
> >  DISKDIR /mnt/disk2
> >  DISKDIR /mnt/disk3
> >  DISKDIR /mnt/disk4
> 
> Well I spent a few hours running this on the quad xeon (aic7xxx).
> 
> There were no hangs, and there was no appreciable performance difference
> between 2.5.69, 2.6.69-mm7++ with AS and 2.5.69-mm7++ with deadline.
> 
> Please confirm that the hang only happened with the anticipatory scheduler?
Yes. Those are the only hangs. 
> 
> It could require a particular device driver to reproduce.  Please see if
> you can generate that sysrq-T output.  Also if you can try a different
> device driver sometime that would be interesting.  There seem to be several
> alternate ISP drivers around - the feral driver perhaps, and the new one in
> the linux-scsi tree.

Okay - i have been using qlogicfc,but there are others.. 
OSDL is moving this weekend, so it'll be a bit before i have a machine up.
cliffw

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


