Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSGPL6g>; Tue, 16 Jul 2002 07:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSGPL6f>; Tue, 16 Jul 2002 07:58:35 -0400
Received: from conn6m.toms.net ([64.32.246.219]:21740 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S317550AbSGPL6e>;
	Tue, 16 Jul 2002 07:58:34 -0400
Date: Tue, 16 Jul 2002 08:01:23 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Christian Ludwig <cl81@gmx.net>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18 
In-Reply-To: <200207152131.g6FLVveP031612@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.44.0207160749470.20424-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, bzip2 is not used because it needs around 1MiB for buffers when
> uncompressing, RAM which just isn't there when booting (it has to work in
> the mythical PC 640KiB, IIRC). Or am I missing something here?

The reason bzip2 has not been thought desirable is as much the slowerness
as it is the biggerness, not something to do with the 640, after all, the
difference betwixt zImage and bzImage already is that bzImage loads high.

Note, it does not require "around 1MiB", it requires 350K if -1 -s is used,
and 3700K if -9 is used.  Reasonable use would be, say, 1600K for -6 -s, it
could certainly make a kernel that would boot in 4MB into one that requires
8MB, but, in many situations, that just isn't an issue, for example, if you
are going to be loading ramdisks, anyway, or an X server.  -Tom




