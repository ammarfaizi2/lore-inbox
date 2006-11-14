Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933285AbWKNBGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933285AbWKNBGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933299AbWKNBGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:06:54 -0500
Received: from elvis.mu.org ([192.203.228.196]:10718 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S933285AbWKNBGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:06:54 -0500
Message-ID: <455916A5.2030402@FreeBSD.org>
Date: Mon, 13 Nov 2006 17:06:45 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a proof-of-concept for this since August, and finally got around to
somewhat cleaning it up.

It can certainly still be improved, namely by using vgetcpu() instead of CPUID
to find the cpu number (but I couldn't get it to work, when I tried).
Another possible improvement would be to use RDTSCP when available.
There's also a small race in do_gettimeofday(), vgettimeofday() and
vmonotonic_clock() but I've never seen it happen.

Suggestions are welcome.

-- Suleiman


