Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSIETAe>; Thu, 5 Sep 2002 15:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSIETAe>; Thu, 5 Sep 2002 15:00:34 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:10763 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318035AbSIETAd>; Thu, 5 Sep 2002 15:00:33 -0400
Message-ID: <3D77AA63.D4E5AA9F@zip.com.au>
Date: Thu, 05 Sep 2002 12:02:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning/turning off disc caching?
References: <Pine.LNX.4.43.0209051929160.2388-100000@merlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kianusch Sayah Karadji wrote:
> 
> Hi!
> 
> Is there a way tuning (down) or turning off the disc caching in Linux for
> certain devices?
> 
> What I do is writing data via dd or mkisofs directly to a DVD-RAM
> (/dev/srX).  The kernel sees the DVD-RAM as a hard-disc.  It works fine.
> The Problem is that during the write operation (which takes some time for
> 4,7GB data).  The system slows down extremely and all the memory is used
> for caching.
> 

There are no very good solutions to this at present.  The following should
help:

- Drastically decrease the dirty memory thresholds in /proc/sys/vm/bdflush

- Make the writing application run fsync(fd) every few megabytes.

- Run /bin/sync once per second.
