Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279790AbRKMWtk>; Tue, 13 Nov 2001 17:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278617AbRKMWtd>; Tue, 13 Nov 2001 17:49:33 -0500
Received: from mail002.mail.bellsouth.net ([205.152.58.22]:45768 "EHLO
	imf02bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279790AbRKMWtU>; Tue, 13 Nov 2001 17:49:20 -0500
Message-ID: <3BF1A359.296F7AE2@mandrakesoft.com>
Date: Tue, 13 Nov 2001 17:48:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Differences between 2.2.x and 2.4.x initrd
In-Reply-To: <20011113150317.G329@visi.net> <E163kVM-0005Rf-00@gondolin.me.apana.org.au> <20011113163443.I329@visi.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> 
> On Wed, Nov 14, 2001 at 07:50:00AM +1100, Herbert Xu wrote:
> > Ben Collins <bcollins@debian.org> wrote:
> >
> > > Well, the point being that 2.2.x worked implicitly, and 2.4.x doesn't. I
> > > don't want to have to tell people who have been using tilo forever and a
> > > day that they now have to add additional command line to get it to work
> > > with 2.4.x.
> >
> > You don't have to.  Just setup linuxrc to echo the right stuff into
> > /proc/sys/kernel/real-root-dev
> 
> Yeah, which is listed under the "Obsolete" section in
> Documentation/initrd.txt. The assumption I'm making here is that if
> /linuxrc fails to execute, it falls back to /sbin/init on the currently
> mounted root filesystem. Assumptions are bad, but I don't see why it
> can't work like this. If there is a filesystem already mounted, it
> should be used.

Really?  I always thought the standard behavior of initrd was "umount
ramdisk unless" not "umount ramdisk if", implying you need to do
something special (like root=/dev/ram) to keep the initrd around.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

