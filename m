Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSIAIZc>; Sun, 1 Sep 2002 04:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSIAIZc>; Sun, 1 Sep 2002 04:25:32 -0400
Received: from employees.nextframe.net ([212.169.100.200]:5374 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S316569AbSIAIZb>; Sun, 1 Sep 2002 04:25:31 -0400
Date: Sun, 1 Sep 2002 10:30:16 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: wli@holomorphy.com, vantuyl@csc.smsu.edu, bryon@csc.smsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re:  [qlogicisp.c PROBLEM 2.5] OOPS: "Unable to handle kernel paging request ..."
Message-ID: <20020901103016.A1286@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <20020830103046.B107@sexything> <20020830171437.A107@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830171437.A107@sexything>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 05:14:37PM +0200, Morten Helgesen wrote:
> On Fri, Aug 30, 2002 at 10:30:46AM +0200, Morten Helgesen wrote:
> > Hey, Jason and Bryon!
> > 
> > Got this one last night - it is def. reproducible. Vanilla 2.5.32.
> > 
> > Haven't got time to look into this myself until tonight, so I thought
> > I should let you guys know. 
> 
> Aah - looks like it is PCI DMA related. I`ll see if I can whip up a patch
> this weekend. 

Hmm ... it may actually look like though I have a hosed controller
on my hands, and that it is actually the SCSI error handling (or lack thereof)
that causes the oops ... something tells me that 2.4.19 is able to 'offline'
the controller correctly, but 2.5.32 is not ...

Bill, have you looked closer into this ? Even though a hosed controller
is the reason for my OOPS, I guess that won`t explain the OOPS you`re seing.

> 
> > 
> > Anyone on lkml with comments ? I don`t get this OOPS with 2.4.19, and 
> > the changes from qlogicisp.c in 2.4.19 to qlogicisp.c in 2.5.32 look
> > minimal. Only cli -> spinlock and io_request_lock -> host->host_lock
> > as far as I can see from a quick glance.
> > 
> 
> [snip]
> 

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
