Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757194AbWKVXyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194AbWKVXyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757193AbWKVXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:54:39 -0500
Received: from main.gmane.org ([80.91.229.2]:2735 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1757194AbWKVXyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:54:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Entropy Pool Contents
Date: Thu, 23 Nov 2006 00:54:03 +0100
Message-ID: <ek2nva$vgk$1@sea.gmane.org>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e179241233.adsl.alicedsl.de
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(PEBKAC warning. I'm probably doing something dump. I just don't know
what...)

I seem to have an entropy pool on a headless machine which is not nearly
empty (a common problem in this case, I know), but completely empty and
stuck in this state...

Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
0
Hornburg:~# fuser /dev/urandom
Hornburg:~# lsof | grep random
Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
0
Hornburg:~# dd if=/dev/hdf of=/dev/urandom bs=512 count=1
1+0 records in
1+0 records out
512 bytes transferred in 0.016268 seconds (31473 bytes/sec)
Hornburg:~# dd if=/dev/hdf of=/dev/random bs=512 count=1
1+0 records in
1+0 records out
512 bytes transferred in 0.031943 seconds (16029 bytes/sec)
Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
0
Hornburg:~# fuser /dev/urandom
Hornburg:~# fuser /dev/random
Hornburg:~# lsof | grep random
Hornburg:~# cat /proc/sys/kernel/random/poolsize
4096
Hornburg:~#

Also causing disk activities doesn't help at all. (Two disks on a Promise
PDC20268 controller.)

The system runs a rather ancient Debian Sarge 2.4 kernel:
Linux Hornburg 2.4.27-3-386 #1 Thu Sep 14 08:44:58 UTC 2006 i486 GNU/Linux

However as the machine itself is also ancient, the 2.4 seems like a good
match. And also 2.4 ought to have a refilling entropy pool, doesn't it?

Maybe someone can shed some light on what's happening here...

Greetings,

  Gunter

