Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUHJDdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUHJDdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 23:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUHJDdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 23:33:07 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:59027 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266864AbUHJDdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 23:33:02 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Albert Cahalan <albert@users.sf.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
In-Reply-To: <cone.1092092365.461905.29067.502@pc.kolivas.org>
References: <1092082920.5761.266.camel@cube>
	 <cone.1092092365.461905.29067.502@pc.kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1092099669.5759.283.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Aug 2004 21:01:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 18:59, Con Kolivas wrote:
> Albert Cahalan writes:
> 
> 
> > Joerg:
> >    "WARNING: Cannot do mlockall(2).\n"
> >    "WARNING: This causes a high risk for buffer underruns.\n"
> > Fixed:
> >    "Warning: You don't have permission to lock memory.\n"
> >    "         If the computer is not idle, the CD may be ruined.\n"
> > 
> > Joerg:
> >    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
> >    "WARNING: This causes a high risk for buffer underruns.\n"
> > Fixed:
> >    "Warning: You don't have permission to hog the CPU.\n"
> >    "         If the computer is not idle, the CD may be ruined.\n"
> 
> Huh? That can't be right. Every cd burner this side of the 21st century has 
> buffer underrun protection.

I'm pretty sure my FireWire CD-RW/CD-R is from
another century. Not that it's unusual in 2004.

> I've burnt cds _while_ capturing and encoding 
> video using truckloads of cpu and I/O without superuser privileges, had all 
> the cdrecord warnings and didn't have a buffer underrun.

That's cool. My hardware won't come close to that.
Burning a coaster costs money.

Let me put it this way: $$ $ $$$ $$ $ $$$ $$ $

The warning, if re-worded, will save people from
frustration and wasted money.

> Last time I gave 
> superuser privilege to cdrecord it locked my machine - clearly it wasn't 
> rt_task safe.

So, you've been working on the scheduler anyway...
An option to reserve some portion of CPU time for
emergency use (say, 5% after 1 second has passed)
would let somebody get out of this situation.

Reporting and/or fixing the cdrecord bug is nice too.


