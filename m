Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUISKLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUISKLn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 06:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269209AbUISKLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 06:11:43 -0400
Received: from web11906.mail.yahoo.com ([216.136.172.190]:28168 "HELO
	web11906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269208AbUISKLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 06:11:41 -0400
Message-ID: <20040919101139.98941.qmail@web11906.mail.yahoo.com>
Date: Sun, 19 Sep 2004 03:11:39 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
To: Jon Smirl <jonsmirl@gmail.com>,
       Vladimir Dergachev <volodya@mindspring.com>
Cc: Keith Packard <keithp@keithp.com>, Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910409181916446719b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jon Smirl <jonsmirl@gmail.com> wrote:

> You did that from an xterm, right? Which console device is the xterm
> running on?
> 
> X starts up a process that knows which device it is running and it can
> remember that device since X stays running.
> 
Remember X opens the VC sepratly from it's console, hence it workes even
when run from a serial or ssh terminal.

> Maybe the answer is that this is something for the VC layer since the
> VC layer stays running and knows what device it was started on. An
> escape sequence could query the device from the VC terminal emulator.
> 
> Is there some way to figure this out from the environment? 
> 
> On Sat, 18 Sep 2004 21:57:32 -0400 (EDT), Vladimir Dergachev
> <volodya@mindspring.com> wrote:
> > On Sat, 18 Sep 2004, Jon Smirl wrote:
> > > Isn't there an enviroment variable that tells what device is the
> > > console for the session? How do you tell what serial port you're on
> > > when multiple people are logged in on serial lines?
> > 
> > From any program you can do this:
> > 
> > volodya@silver:~$ ls -l /proc/self/fd/0
> > lrwx------  1 volodya users 64 Sep 18 21:56 /proc/self/fd/0 ->
> /dev/pts/1
> > 
> > So you get the pointer to the actual device stdin is associated to.
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
