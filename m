Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283357AbRK2SKH>; Thu, 29 Nov 2001 13:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283361AbRK2SJ4>; Thu, 29 Nov 2001 13:09:56 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:60129 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283357AbRK2SJq>; Thu, 29 Nov 2001 13:09:46 -0500
Date: Thu, 29 Nov 2001 19:09:23 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: "Nathan G. Grennan" <ngrennan@okcforum.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16 revisited
In-Reply-To: <1007052513.1470.5.camel@cygnusx-1.okcforum.org>
Message-ID: <Pine.LNX.4.42.0111291904190.2184-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > ok, I doubled checked things. It seems mounting an ext3 filesystem as
> > > ext2 is somewhat a myth. If the kernel supports ext3 it still mounts it
> > > as ext3 even if /etc/fstab says ext2. 
> > 
> > really on other partitions than root-fs ?
> > 
> > -- 
> > Oktay Akbal
> 
> I am not positive about mounting non-root filesystems. I would suspect
> it is just a problem with root filesystems.

Why do you think that fstab matters for root-fs ? root-fs needs to be 
mounted to read fstab. So autodetection must be done for root-fs.
And if the fs has a journal it is ext3. If you do not want that  behaviour
you might use a option to lilo, but I don't know of any option to specify
the root-fs-tyoe. Or you need to use an initrd to mount explicit as ext2
and pivot-root it to / ?

-- 
Oktay Akbal

