Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRDHVt1>; Sun, 8 Apr 2001 17:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRDHVtR>; Sun, 8 Apr 2001 17:49:17 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:19979 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S131079AbRDHVtH>; Sun, 8 Apr 2001 17:49:07 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: build -->/usr/src/linux
Date: Sun, 8 Apr 2001 21:49:06 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9aqmci$gn2$1@ncc1701.cistron.net>
In-Reply-To: <3AD079EA.50DA97F3@rcn.com> <20010408161620.A21660@flint.arm.linux.org.uk> <3AD0A029.C17C3EFC@rcn.com>
X-Trace: ncc1701.cistron.net 986766546 17122 195.64.65.67 (8 Apr 2001 21:49:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3AD0A029.C17C3EFC@rcn.com>,
Marvin Stodolsky  <stodolsk@rcn.com> wrote:
>Thanks for responding.  But I would still like to understand what the
>functionality is of the build --> /usr/src/linuc.  Is it dispensable,
>once the module tree has been installed? 

It's needed for modules that are distributed sperately, so that
they can use cc -I /lib/modules/`uname -r`/build/include

Or even

	l=`pwd`
	cd /lib/modules/`uname -r`/build
	make $l/module.o

.. but there should be a cleaner way to get at the CFLAGS used
to compile the kernel.

Mike.

