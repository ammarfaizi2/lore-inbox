Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272314AbRH3QZe>; Thu, 30 Aug 2001 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbRH3QZ3>; Thu, 30 Aug 2001 12:25:29 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:43128 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272314AbRH3QZM>; Thu, 30 Aug 2001 12:25:12 -0400
Date: Thu, 30 Aug 2001 12:25:29 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Michael E Brown <michael_e_brown@dell.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <Pine.LNX.4.33.0108301108210.1213-100000@blap.linuxdev.us.dell.com>
Message-ID: <Pine.LNX.4.33.0108301222010.12593-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Michael E Brown wrote:

> In reference to the ia64 ioctls:  I'm sorry, but disk access APIs that
> don't allow access to the whole disk are what is broken. These ioctls
> would not be necessary if you could actually write to the last sector of
> an odd-sized disk. Have you read the comments surrounding this ioctl?

Were people's heads on backwards when they wrote the ioctl?  Quite simply:
if an ugly hack has to be put in place, put it in the right place.  In
this case, it would have been *trivial* to put the UGLY hack in
fs/block_dev.c and just make read/write transparently able to access the
end of the disk.  No adding crap to the API, and certainly not risking
truely unexpected disk io due to an incorrect ioctl.

		-ben

-- 
"The world would be a better place if Larry Wall had been born in
Iceland, or any other country where the native language actually
has syntax" -- Peter da Silva

