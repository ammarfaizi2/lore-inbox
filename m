Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUAGJ2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUAGJ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:28:52 -0500
Received: from web13905.mail.yahoo.com ([216.136.175.68]:33042 "HELO
	web13905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266157AbUAGJ2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:28:03 -0500
Message-ID: <20040107092802.62517.qmail@web13905.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Wed, 7 Jan 2004 01:28:02 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Any changes in Multicast code between 2.4.20 and 2.4.22/23 ? -> New Info
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernels are 2.4.22 and 2.4.23 (now .24) with some NFS patches. In
>the case of 2.4.24 those are:
>
>01-posix_race
>02-fix_commit
>03-fix_osx
>04-fix_lockd3
>06-fix_unlink
>07_seekdir
>
>from http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-rc1 None of
>those looks like it does something to multicasts. In the worst case I
>could try to run with plain 2.4.22/23, but that would have to ait
until
>Wednesday.

 OK, here are some more hints on the problem. To rule out the NFS
pathces and pinpoint the time of problem introduction I tested my setup
with 2.4.21 vanilla and 2.4.22 vanilla. With 2.4.21 vanilla everything
works as before/expected. With 2.4.22 vanilla the Ganglia multicasts
are not seen in the system.

 To rule out further causes, I rebuilt the 2.4.21 version of tg3.o
(V1.5) for the 2.4.22 kernel (tg3-V1.6). Unfortunatelly the problem did
not go away, which point into the direction of the pretty large
igmp/multicast changes introduced with 2.4.22. Debugging tg3 would have
been easier ...

 As before - I am pretty keen on getting this fixed. So any hints are
appreciated.

 Just to avoid the obvious - the kernel-configuration for my 2.4.21 and
2.4.22 builds are almost identical (modulo symbols that got
added/removed to/from 2.4.22). The user-space is identical.

Cheers
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
