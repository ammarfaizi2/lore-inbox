Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTEMVpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTEMVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:45:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:54251 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262390AbTEMVpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:45:14 -0400
Date: Tue, 13 May 2003 14:53:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4
Message-Id: <20030513145335.2337e0f7.akpm@digeo.com>
In-Reply-To: <87addq7fr8.fsf@lapper.ihatent.com>
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
	<20030513001135.2395860a.akpm@digeo.com>
	<87n0hr8edh.fsf@lapper.ihatent.com>
	<20030513011232.67c300d0.akpm@digeo.com>
	<87addq7fr8.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 21:57:55.0791 (UTC) FILETIME=[B58A65F0:01C3199A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> * Synaptics touchpad driver as of 2.5.69 does not recognise the "tap
>   to click" functionality, and doesn't seem parse it's boot param to
>   enable it, I get it to work by hardcoding the PARM-line in
>   driver/input/mouse/psmouse.c to a "1". This might very well boil
>   down to user error (PEBKAC) on the boot time parm, but the auto
>   detection that worked up to .69 is b0rken.

There's some synaptics patch in -mm which looks like it needs

	modprobe psmouse synaptics_tap=1

I'm not sure what the story is on getting all that finished off.

> * On -mm3 under some loads mplayer can get very erratic, and after
>   playing a videostream for about 10-15 mins it gets progressivly more
>   prone to stalling. Moving the mousepointer into the window, and wiggling
>   it a bit restores it for a while.

grr.  Can you run `vmstat 1' and see if those stalls correspond with swap
or disk I/O?

