Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279233AbRKAQBX>; Thu, 1 Nov 2001 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279238AbRKAQBO>; Thu, 1 Nov 2001 11:01:14 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:22807 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279233AbRKAQAw>; Thu, 1 Nov 2001 11:00:52 -0500
Date: Thu, 1 Nov 2001 11:00:23 -0500 (EST)
From: Peter Jones <pjones@redhat.com>
X-X-Sender: <pjones@lacrosse.corp.redhat.com>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
cc: Paul Mackerras <paulus@samba.org>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
In-Reply-To: <Pine.LNX.4.33.0111011318420.1468-100000@tahallah.demon.co.uk>
Message-ID: <Pine.LNX.4.33.0111011053140.9216-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Alex Buell wrote:

> On Thu, 1 Nov 2001, Paul Mackerras wrote:
> 
> > > Anyway, I can fix it now by adding the appropriate AFMT_S16_BE statement
> > > guarded by a #ifdef but this sucks. Thanks to Peter Jones who spotted this
> > > one.
> >
> > Why can't you just use AFMT_S16_NE on all platforms?  That is supposed
> > to be equal to AFMT_S16_BE on big-endian platforms and to AFMT_S16_LE
> > on little-endian platforms.  NE == native endian.
> 
> Ah, is that what it does. OK, I'll carefully suggest to the authors of ESD
> (preferably with a blunt trauma instrument) using AFMT_S16_NE. Thanks.

It should probably be mentioned that you're using a really old version of 
ESD, and that they've at least made it so that you'll get the right one 
for any BE machine.  NE is still the better answer though -- now their 
configure script figures out BE/LE, and it'll build wrong if you're 
crosscompiling.

-- 
        Peter

"Don't everyone thank me at once!"
		-- Solo

