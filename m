Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269945AbRHELt1>; Sun, 5 Aug 2001 07:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269946AbRHELtS>; Sun, 5 Aug 2001 07:49:18 -0400
Received: from s340-modem108.dial.xs4all.nl ([194.109.160.108]:12937 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S269945AbRHELtM>;
	Sun, 5 Aug 2001 07:49:12 -0400
Date: Sun, 5 Aug 2001 13:49:18 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.8-pre[34]: Mount usb camera "hangs"
Message-ID: <Pine.LNX.4.33.0108051233100.6003-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed with kernel 2.4.8-pre[34] mounting my usb sony dsc-p1, mount
"hangs", and i can't kill the mount pid.
the load is going to 4 a 5 (top) on my almost idle machine, and where
vmstat reports 100% idle.

kernel 2.4.7 works fine, but i havn't tested 2.4.8-pre[12].

Stracing the 'mount /dscp1' command, the actual mount system call, which
never returns:
mount("/dev/sdb1", "/dscp1", "vfat", 0xc0ed0000, 0x805be08	<hanging here>

I noted (lsmod) usb-storage shows (initializing), and seems not to be
ready.

Greatings,

-- 
Arjan Filius
mailto:iafilius@xs4all.nl


