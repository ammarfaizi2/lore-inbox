Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280892AbRKLSBT>; Mon, 12 Nov 2001 13:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280894AbRKLSBJ>; Mon, 12 Nov 2001 13:01:09 -0500
Received: from 229.124.18.216.gt-est.net ([216.18.124.229]:37513 "EHLO
	gateway.max-t.com") by vger.kernel.org with ESMTP
	id <S280883AbRKLSA7>; Mon, 12 Nov 2001 13:00:59 -0500
Date: Mon, 12 Nov 2001 13:01:23 -0500 (EST)
From: "Gord R. Lamb" <glamb@max-t.com>
X-X-Sender: <glamb@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: I/O lockup
Message-ID: <Pine.LNX.4.32.0111121248360.4885-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I've been having a problem for a while now with a strange lockup induced
under heavy SCSI I/O (particularly when I write directly to block devices
with dd of=/dev/sd?, but also when writing to a filesystem on that
device).  I'm writing around 50-100mb/sec over FC (qlogic 2200) under
Linux 2.4 (tried 2.4.3 through 2.4.10).

It seems that some vm or I/O related spinlock is being taken and held, but
not released (?).  There is no oops or BUG() or anything (no messages at
all in fact).. all I/O just stops.  I can still invoke sysrq, type
characters at the console, etc.  In fact, usually top continues to run and
display kswapd as the dominant process.

Any ideas?

- Gord R. Lamb (glamb@max-t.com)
  Maximum Throughput, Inc.
  Sr. Systems Architect

