Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVGGRi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVGGRi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGGRfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:35:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34233 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261511AbVGGRdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:33:31 -0400
Date: Thu, 7 Jul 2005 19:34:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: "'Clemens Koller'" <clemens.koller@anagramm.de>,
       "'Lenz Grimmer'" <lenz@grimmer.com>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>, hdaps-devel@lists.sourceforge.net,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050707173412.GL24401@suse.de>
References: <42CD600C.2000105@anagramm.de> <002401c58317$865ee6a0$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002401c58317$865ee6a0$600cc60a@amer.sykes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Alejandro Bonilla wrote:
> 
> > Hello,
> >
> > Just for the records....
> > -----
> > root@ecam:~$ ./headpark /dev/hda
> > head not parked 4c
> > -----
> >
> > HDD is a desktop Maxtor Diamond MaxPlus 9 120GB
> > on a Promise Ultra133 TX2 IDE Controller.
> >
> > Well, sure, it's not a notebook HDD, but maybe it's possible
> > to give headpark a more generic way to get the heads parked?
> >
> > Are the commands different per HDD model / manufacturer?
> > Then we might need some information to send the proper
> > commands to the different types?!
> > And if there is no headpark command, might it be valuable to send
> > the HDD a shutdown instead?
> >
> > PS:
> > I'm working on an embedded PowerPC (MPC8540) system which
> > will be turned into a high-resolution portable camera in
> > the future (with acceleration sensors for the right image
> > orientation). Therefore it will likely be another candidate
> > for a Drop'n'Park or Drop'n'Stop (tm) feature as are planning
> > to put a 2.5" notebook HDD into the cam, too.
> >
> > Greets,
> >
> > Clemens Koller
> 
> Clemens,
> 
> Thanks for bringing this up. We were actually in a conversation about
> this subject in IRC a couple of minutes ago, and this actually came
> up. It would be a good idea to kick this little script into the kernel
> so that people that develop new accelerometers will be able to just
> make the call from the script already in the kernel.

What is needed is to flesh out what the kernel interface should looke
like. I suggested a sysfs file for suspending and resuming access to the
device, if people have other ideas they should voice them.

> How do we go by making this script maybe more broad, or simple so that
> it can be implemented on more devices?

It's a test utility, I just wrote it so people could test. The actual
command used woule be used in the internal implementation. The file
itself holds no other value than for testing purposes.

-- 
Jens Axboe

