Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269725AbUISCQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbUISCQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 22:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269731AbUISCQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 22:16:28 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:62691 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269725AbUISCQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 22:16:26 -0400
Message-ID: <9e4733910409181916446719b8@mail.gmail.com>
Date: Sat, 18 Sep 2004 22:16:26 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Cc: Keith Packard <keithp@keithp.com>, Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0409182156160.3498@node2.an-vo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091815125ef78738@mail.gmail.com>
	 <E1C8oiI-0001xU-UG@evo.keithp.com>
	 <9e47339104091817545b3d2675@mail.gmail.com>
	 <Pine.LNX.4.61.0409182156160.3498@node2.an-vo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You did that from an xterm, right? Which console device is the xterm running on?

X starts up a process that knows which device it is running and it can
remember that device since X stays running.

Maybe the answer is that this is something for the VC layer since the
VC layer stays running and knows what device it was started on. An
escape sequence could query the device from the VC terminal emulator.

Is there some way to figure this out from the environment? 

On Sat, 18 Sep 2004 21:57:32 -0400 (EDT), Vladimir Dergachev
<volodya@mindspring.com> wrote:
> On Sat, 18 Sep 2004, Jon Smirl wrote:
> > Isn't there an enviroment variable that tells what device is the
> > console for the session? How do you tell what serial port you're on
> > when multiple people are logged in on serial lines?
> 
> From any program you can do this:
> 
> volodya@silver:~$ ls -l /proc/self/fd/0
> lrwx------  1 volodya users 64 Sep 18 21:56 /proc/self/fd/0 -> /dev/pts/1
> 
> So you get the pointer to the actual device stdin is associated to.

-- 
Jon Smirl
jonsmirl@gmail.com
