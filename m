Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTJRLun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 07:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTJRLun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 07:50:43 -0400
Received: from cpc2-blfs2-6-0-cust226.blfs.cable.ntl.com ([81.99.21.226]:13196
	"EHLO foobox") by vger.kernel.org with ESMTP id S261569AbTJRLum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 07:50:42 -0400
Message-ID: <3F912911.4080707@ntlworld.com>
Date: Sat, 18 Oct 2003 12:50:41 +0100
From: Matt <dirtbird@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6 StumbleUpon/1.87
X-Accept-Language: en, en-gb, ja
MIME-Version: 1.0
To: bunk@fs.tum.de
Cc: linux-kernel@vger.kernel.org
Subject: Re:Re: [2.6 patch] add a config option for -Os compilation
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The main effect of -Os compared to -O2 (besides disabling some
 > reordering of the code and prefetching) is the disabling of various
 > alignments. I doubt that's a win on all CPUs.

Well the big win I found from -Os is the disabling of code inlining.
So I found I got much better code from -finline-limit=100. I
found this value after trial and error (via a bit of bench marking).
Mind you this is what works for my athlon.. Mind you the
difference isnt that huge.. I found turning on -Winline and
-finline-limit handy for finding the culprits of huge inlines..

    matt


