Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286993AbSABUde>; Wed, 2 Jan 2002 15:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284140AbSABUdY>; Wed, 2 Jan 2002 15:33:24 -0500
Received: from [212.2.162.33] ([212.2.162.33]:11211 "EHLO weasel")
	by vger.kernel.org with ESMTP id <S284141AbSABUdI>;
	Wed, 2 Jan 2002 15:33:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Golden <david.golden@oceanfree.net>
Organization: Legion
To: linux-kernel@vger.kernel.org
Subject: Re: How can one get System.map w/o vmlinux?
Date: Wed, 2 Jan 2002 20:34:46 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net> <200201021951.g02JpCSr021687@svr3.applink.net>
In-Reply-To: <200201021951.g02JpCSr021687@svr3.applink.net>
MIME-Version: 1.0
Message-Id: <02010220344600.01423@golden1.goldens.ie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've often thought that an alternate scheme would be vaguely
"neater", just have a  boot directory with per-version subdirectories,
and a single symlink "current" to the  one you want to use.
I've never particularly had an urge to try to use one kernel version's
System.map and possibly initrd.img with another version :-)

No doubt there's a reason for not doing it this way, it's
probably been done to death years ago on lkml,
and personally, I don't find the current minor symlink tangle
much harder, but I only seem have 3 or so kernels in /boot at any one time -
I can imagine that having lots of kernels, system.maps and initrds all
in one directory would get tiresome with the current way, but would
be relatively painless like this:

/boot/2.2.20/vmlinuz
/boot/2.2.20/System.map
/boot/2.2.20/initrd.img
/boot/2.4.17/vmlinuz
/boot/2.4.17/System.map
/boot/2.4.17/initrd.img
...
ln -s /boot/2.4.17/  /boot/current
ln -s /boot/2.2.20/  /boot/old
etc.


