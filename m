Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272195AbRIJX4H>; Mon, 10 Sep 2001 19:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRIJXz4>; Mon, 10 Sep 2001 19:55:56 -0400
Received: from 200.telesoft.com ([140.99.12.200]:3192 "EHLO
	scottspc.sunbelt.com") by vger.kernel.org with ESMTP
	id <S272195AbRIJXzp>; Mon, 10 Sep 2001 19:55:45 -0400
Message-ID: <3B9D531D.E0157C7F@telesoft.com>
Date: Mon, 10 Sep 2001 16:56:13 -0700
From: Scott Dudley <scott@telesoft.com>
Organization: Telesoft Corp.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.14 and nfs compatablity with at&t r32v3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just recently exported via NFS a file system from a 2.2.14 machine (RH 6.2) to
an old Motorola m88k system running SVR3.  A few hours thereafter, the PC
crashed.  There was no output on the console and it had to be power-cycled.  The
following appears in syslog (messages) immediately prior to the crash:

Sep 10 13:52:34 sunbelt2 kernel: nfs: RPC call returned error 111
Sep 10 13:52:34 sunbelt2 kernel: RPC: task of released request still queued!
Sep 10 13:52:34 sunbelt2 kernel: RPC: (task is on xprt_pending)
Sep 10 13:52:35 sunbelt2 kernel: nfs: RPC call returned error 111
Sep 10 13:52:35 sunbelt2 kernel: RPC: task of released request still queued!
Sep 10 13:52:35 sunbelt2 kernel: RPC: (task is on xprt_pending)
Sep 10 13:52:36 sunbelt2 kernel: nfs: RPC call returned error 111
Sep 10 13:52:36 sunbelt2 kernel: RPC: task of released request still queued!
Sep 10 13:52:36 sunbelt2 kernel: RPC: (task is on xprt_pending)
...and so on

This has happened twice now.  I tried also to mount an NFS file system exported
via the SVR3 box to the linux machine.  When i did so, the SVR3 machine
crashed.  This is the first time I've used the kernel-based server.  I've
previously (several years ago) used the user-space server with kernel 1.2.13 to
connect to the same SVR3 machine with no problems.  Is anyone aware of this
problem or its cause?

Please cc any responses to this address as I'm not a list subscriber.

Many thanks.

