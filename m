Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279311AbRJWHfR>; Tue, 23 Oct 2001 03:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279310AbRJWHfH>; Tue, 23 Oct 2001 03:35:07 -0400
Received: from pa92.nowy-targ.sdi.tpnet.pl ([217.97.37.92]:60912 "EHLO
	nt.kegel.com.pl") by vger.kernel.org with ESMTP id <S279309AbRJWHet>;
	Tue, 23 Oct 2001 03:34:49 -0400
Message-ID: <000c01c15ba6$2c850b60$72da4dd5@abi>
From: "Albert Bartoszko" <abartoszko@nt.kegel.com.pl>
To: "Alexander Viro" <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0110220242290.2294-100000@weyl.math.psu.edu>
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
Date: Tue, 23 Oct 2001 11:28:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...............
> Check that your modules.conf contains
>
> post-install binfmt_misc mount -t binfmt_misc none /proc/sys/binfmt_misc
> pre-remove binfmt_misc umount /proc/sys/binfmt_misc
>
Yes, now contains, and mount, umount and binfmt work propely.
This should be documented in sources

xx:/tmp# egrep -Hr "mount[[:space:]]+-t[[:space:]]+binfmt_misc"
/usr/src/linux
xx:/tmp#

But I still  can't unload module (unmounted):
#rmmod binfmt_misc
binfmt_misc: Device or resource busy



