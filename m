Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272718AbRIPTeD>; Sun, 16 Sep 2001 15:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272721AbRIPTdx>; Sun, 16 Sep 2001 15:33:53 -0400
Received: from [194.213.32.137] ([194.213.32.137]:21508 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S272712AbRIPTds>;
	Sun, 16 Sep 2001 15:33:48 -0400
Message-ID: <20010916213353.E216@bug.ucw.cz>
Date: Sun, 16 Sep 2001 21:33:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
In-Reply-To: <3BA3156C.9050704@korseby.net> <20010915144236.V26627@khan.acc.umu.se> <20010916001943.A984@bug.ucw.cz> <20010915175100.D1541@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010915175100.D1541@turbolinux.com>; from Andreas Dilger on Sat, Sep 15, 2001 at 05:51:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Install crc loop device, and if disk does silent errors, you'll know.
> 
> Where do you store the CRCs?  It appears that they are written to another
> block device.  Also, how do you initialize the CRC table for an existing
> filesystem?

You just read the device in special mode. That forces it to recompute
crc-s.

> What would make this considerably more useful is to be able to write the
> CRCs into a regular file, as it would be a bit of a pain to have a partition
> for each CRC loop device to store the CRCs in.

By -o loop, you can turn regular file into blockdevice ;-).

> Otherwise, it looks very useful, and could be handy in tracking down
> reports like this where it is unclear where the data corruption is.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
