Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSGHXCL>; Mon, 8 Jul 2002 19:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSGHXCK>; Mon, 8 Jul 2002 19:02:10 -0400
Received: from [209.184.141.189] ([209.184.141.189]:50883 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317257AbSGHXCJ> convert rfc822-to-8bit;
	Mon, 8 Jul 2002 19:02:09 -0400
Subject: Re: Terrible VM in 2.4.11+?
From: Austin Gonyou <austin@digitalroadkill.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020709005025.B1745@mail.muni.cz>
References: <20020709001137.A1745@mail.muni.cz>
	 <1026167822.16937.5.camel@UberGeek>  <20020709005025.B1745@mail.muni.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 08 Jul 2002 18:04:45 -0500
Message-Id: <1026169485.16943.8.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the params I'm running...but it is with a -aa tree, just FYI.

vm.bdflush = 60 1000 0 0 1000 800 60 50 0


On Mon, 2002-07-08 at 17:50, Lukas Hejtmanek wrote:
> Yes, I know a few people that reports it works well for them. How ever for me
> and some other do not. System is redhat 7.2, ASUS A7V MB, /dev/hda is on promise
> controller. Following helps a lot:
> 
> while true; do sync; sleep 3; done
> 
> How did you modify the params of bdflush? I do not want to suspend i/o buffers 
> nor disk cache.. 
> 
> Another thing to notice, the X server has almost every time some pages swaped to
> the swap space on /dev/hda. When bdflushd is flushing buffers X server stops as
> has no access to the swap area during i/o lock.
> 
> On Mon, Jul 08, 2002 at 05:37:02PM -0500, Austin Gonyou wrote:
> > I do things like this regularly, and have been using kernels 2.4.10+ on
> > many types of boxen, but have yet to see this behavior. I've done this
> > same type of test with 16k blocks up to 10M, and not had this problem I
> > usually do test with regard to I/O on SCSI, but have tested on IDE,
> > since we use many IDE systems for developers. I found though, that using
> > something like LVM, and overwhelming it, causes bdflush to go crazy. I
> > can hit the wall you refer to then.When bdflushd is too busy...it does
> > in fact seem to *lock* the system, but of course..it's just bdflush
> > doing it's thing. If I modify the bdflush params..this causes things to
> > work just fine, at least, useable.
> 
> -- 
> Luká¹ Hejtmánek
-- 
Austin Gonyou <austin@digitalroadkill.net>
