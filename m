Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbRDHCAL>; Sat, 7 Apr 2001 22:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRDHCAB>; Sat, 7 Apr 2001 22:00:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55567 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S132418AbRDHB7k>;
	Sat, 7 Apr 2001 21:59:40 -0400
Date: Sat, 7 Apr 2001 18:56:53 -0700
From: Anton Blanchard <anton@samba.org>
To: "Stephen E. Clark" <sclark46@gte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep
Message-ID: <20010407185653.B1046@va.samba.org>
In-Reply-To: <Pine.BSF.4.33.0104032217220.60098-100000@ocdi.sb101.org> <3AC9D108.CBE9C2BB@gte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC9D108.CBE9C2BB@gte.net>; from sclark46@gte.net on Tue, Apr 03, 2001 at 09:32:56AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That happened to me with 2.4.2-ac28 when I tried using DRM.
> I also got the following messages in syslog.
> 
> /var/log/messages.1:Mar 31 12:15:04 joker kernel:
> [drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!

You need to replace down(...->mmap_sem), up(...->mmap_sem) with
down_write(...), up_write(...) in the X11 r128 drm kernel module.

Anton
