Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291893AbSBASCR>; Fri, 1 Feb 2002 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291895AbSBASCI>; Fri, 1 Feb 2002 13:02:08 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:30216 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S291893AbSBASBw>;
	Fri, 1 Feb 2002 13:01:52 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Fri, 1 Feb 2002 10:01:45 -0800
To: Guillaume Boissiere <boissiere@mediaone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New device naming convention
Message-ID: <20020201100145.A21307@vato.org>
In-Reply-To: <3C59F1C3.21004.28F8E65B@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C59F1C3.21004.28F8E65B@localhost>; from boissiere@mediaone.net on Fri, Feb 01, 2002 at 01:39:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Feb at 01:39:15 -0500 boissiere@mediaone.net done said:
> I added this item on my kernel 2.5 status list a few weeks ago, and 
> it seems to be _the_ hot topic for 2.5.
> 
> o Pending   Finalize new device naming convention    (Linus Torvalds)
> 
> What exactly are people expecting Linus to decide on?  And once it 
> has been decided, what is the next step after that?

I tried to explain when I asked that it be added to the list...here's another
go:

I think there are various (especially hotpluggable?) subsystems where
people have issues, but here's one example...

Say I'm a big file or db server in a fibre channel environment and have
1000 disk luns on various disk subsystems and there happen to be 8 paths
to those luns because of how the fabric is set up.  What do those 8000
'sd' devices get named.  And will there be persistence of whatever the
name is?  If I'm booting off 'sdfoo' will the device (host:bus:target:lun)
behind that name be the same between scsi driver loads.  Right now the
user just has to know and control what's going on magically and make sure
the right thing happens.  This might work on a couple devices in your
pc for which you can easily look and see what all the luns are and deduce
how the sd's get populated, figure out which one is the disk you want.
But it doesn't scale.  Persistence may be best solved in userspace, but right
now the kernel assures that there isn't any.

There've been huge discussions in the past about how to handle /dev;
they're in the archive.  Is it a problem that needs an answer?
Is devfs the answer?  Will an answer be in 2.5?

t.

-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
