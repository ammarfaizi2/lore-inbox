Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSDYQiS>; Thu, 25 Apr 2002 12:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313555AbSDYQiR>; Thu, 25 Apr 2002 12:38:17 -0400
Received: from um.es ([155.54.1.1]:55689 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S313537AbSDYQiQ>;
	Thu, 25 Apr 2002 12:38:16 -0400
Date: Thu, 25 Apr 2002 18:37:45 +0200 (CEST)
From: Juan Piernas Canovas <piernas@ditec.um.es>
To: "Neal D. Becker" <nbecker@hns.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Faster logging?
In-Reply-To: <x88662frd4j.fsf@rpppc1.md.hns.com>
Message-ID: <Pine.LNX.4.21.0204251835040.24216-100000@ditec.um.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Apr 2002, Neal D. Becker wrote:

> Trying to debug using printk, we are getting buffer overun.  I think
> that setting klogd to flush faster would fix this.  Man klogd doesn't
> show any option to control the time that klogd sleeps.  Seems to me
> that's a simple option to add.
Try this:

1.- /etc/rc.d/init.d/syslogd stop
2.- klogd -c 1
3.- killall -9 klogd
4.- nice -n -20 cat /proc/kmsg > your_file

You should also increase the buffer size up to 1 MB (see kernel/prink.c).

Best regards.

	Juan.

