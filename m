Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUK0VWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUK0VWL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUK0VWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:22:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1728 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261333AbUK0VWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:22:08 -0500
Date: Sat, 27 Nov 2004 22:22:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernard Normier <bernard@zeroc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <009501c4d4c6$40b4f270$6400a8c0@centrino>
Message-ID: <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr>
References: <006001c4d4c2$14470880$6400a8c0@centrino>
 <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As shown in the code included in my first e-mail, each thread simply
>open("/dev/urandom", O_RDONLY), use read(2) to read 16 bytes, and
>then close the file descriptor.
>Duplicates appear quickly on: single CPU with HT, dual CPU without HT,
>and dual CPU with HT (all with smp kernels)
>But not on a lower end single CPU without HT (2.6.8-1.521 non-smp).

Ok, so it is a case of two "kernel-side" CPUs.

>> Rule of thumb: Post the smallest possible code that shows the problem.
>Will do next time!

That would be great, because it could show that urandom is missing a lock
somewhere.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
