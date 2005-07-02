Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVGBFU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVGBFU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 01:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVGBFU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 01:20:29 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:60092 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261801AbVGBFUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 01:20:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Date: Sat, 2 Jul 2005 00:20:04 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
References: <20050624051229.GA24621@kroah.com> <200507012325.30628.dtor_core@ameritech.net> <20050702045146.GA5303@kroah.com>
In-Reply-To: <20050702045146.GA5303@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507020020.05474.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 July 2005 23:51, Greg KH wrote:
> On Fri, Jul 01, 2005 at 11:25:30PM -0500, Dmitry Torokhov wrote:
> > On Friday 01 July 2005 17:31, Greg KH wrote:
> > > Putting it 
> > > in every device directory would make the 20K scsi device people very
> > > unhappy as I take up even more of their 31bit memory :)
> > > 
> > 
> > I see. That would be an argument for folding all such operationsinto one
> > attribute with bus-specific multiplexor. But really, 20K scsi people are
> > probably better off without sysfs (they should still have hotplug events
> > as far as I can see so hotplug/usev should still work).
> 
> The 20k scsi people need sysfs.  They did the backing store patches for
> it, to make it work sane on their boxes.  They need persistant device
> naming more than almost anyone else.  udev previously would not work
> without sysfs.  For 2.6.12, it now almost can (haven't tried for sure,
> but I think we are now there.)

I believe you can make it work ;)

> 
> > Just to reiterate - by beef is that if you put [un]bind into separate
> > directory similar operations will be split across 2 subdirectories. 
> 
> But I didn't.  They are now both in the same directory.  Look at Linus's
> tree :)
> 

You misunderstood me. I know that both bind and unbind are in the same
directory. I am talking about reconnect/rescan being in one directory
while bind/unbind are in the other while they all perform related
operations.

-- 
Dmitry
