Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130088AbQKBONp>; Thu, 2 Nov 2000 09:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131228AbQKBONf>; Thu, 2 Nov 2000 09:13:35 -0500
Received: from [62.172.234.2] ([62.172.234.2]:42129 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130088AbQKBONU>;
	Thu, 2 Nov 2000 09:13:20 -0500
Date: Thu, 2 Nov 2000 14:14:04 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3-order allocation failed
In-Reply-To: <Pine.LNX.4.21.0011021148330.15168-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0011021411020.2508-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

A simple test seems to show problems with page allocator.

a) take a 6G RAM machine

b) take a 70G harddisk

c) mke2fs on it

observe lots of "0-order allocation failures" while looking at
/proc/meminfo reveals that I still have 5.1G of free memory (presumably
some of it in NORMAL zone, not just all HIGH)... Isn't buddy allocator
clever enough to break up the multi-page chunks if we need single pages?
I don't know.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
