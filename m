Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSKEQBb>; Tue, 5 Nov 2002 11:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSKEQBb>; Tue, 5 Nov 2002 11:01:31 -0500
Received: from tomts9.bellnexxia.net ([209.226.175.53]:20671 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264888AbSKEQA6>; Tue, 5 Nov 2002 11:00:58 -0500
Subject: re: [announce] swap mini-howto (updated)
From: Shane Shrybman <shrybman@sympatico.ca>
To: rddunlap@osdl.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Nov 2002 11:07:32 -0500
Message-Id: <1036512453.15824.10.camel@mars.goatskin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

I thought that it might be possible that the folks who might need this
swap mini-howto might not be the folks who understand terms like "memory
pressure" and "dirty" memory. Have a look at the below and use or don't
use whatever you want. I also included a bit on features and a little
more on priorities.

I also am curious about this sentence:

"Block size in swap space is assumed to be the CPU architecture's
page size."

What should a user be aware of with regard to this info?

Introduction

Linux uses swap space as "extra" or "virtual" memory. When most of
the system's real memory is in use, and there is a need for more,
some data will be moved into swap to free real RAM memory for use by
applications. This is called swapping out. When the data that is
in swap needs to be used it is swapped back in from swap space. The
rate at which data is swapped to and from one or more swap spaces
can be monitored with the vmstat command's swap-in (si) and swap-out
(so) columns.

Linux kernel code and data is not swappable and is never moved to swap.
User code never needs to be written to swap space because it already
exists on disk and can be read in from there if it is required again.
User data can be written to swap space and read back in when needed.

Features

Managing swap with Linux is very easy and flexible compared to most of
proprietary operating systems. Linux's swap spaces can be turned on and
off without a reboot and even while they are in use!

Logical Volumes can be used as swap devices.

Version 0 swap space format is no longer supported in 2.5+.

Swap spaces can be given different priorities, (man 2 swapon) that
determine how the swap spaces will be used. Higher priority swap spaces
will be exhausted first and swap spaces with equal priorities will be
striped. The Priority can be specified at swap space activation with
the swapon command or in the /etc/fstab file.

/dev/hda2       none    swap    pri=5,defaults 0 0
/dev/hde2       none    swap    pri=5,defaults 0 0

Regards,

Shane


