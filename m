Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131372AbRACQJw>; Wed, 3 Jan 2001 11:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRACQJm>; Wed, 3 Jan 2001 11:09:42 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:1796 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S131372AbRACQJb>;
	Wed, 3 Jan 2001 11:09:31 -0500
Message-ID: <3A53476A.9739B3AE@holly-springs.nc.us>
Date: Wed, 03 Jan 2001 10:38:18 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Dr. David Gilbert" <gilbertd@treblig.org>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 3 Jan 2001, Dr. David Gilbert wrote:
> 
> >   I got wondering as to whether the various journaling file
> > system activities were designed to survive the occasional
> > unclean shutdown or were designed to allow the user to just pull
> > the plug as a regular means of shutting down.
> 
> >   Thoughts?

Journaling filesystems only guarantee consistancy of filesystem
metadata. Data that has not been flushed from buffers will be lost, and
applications not given a chance to shut themselves down may do bad
things if you just unplug the box. Journaling mostly means not having to
run FSCK.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
