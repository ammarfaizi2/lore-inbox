Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281118AbRKLWdE>; Mon, 12 Nov 2001 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281079AbRKLWc5>; Mon, 12 Nov 2001 17:32:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45586 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281075AbRKLWcL>; Mon, 12 Nov 2001 17:32:11 -0500
Subject: Re: File System Performance
To: akpm@zip.com.au (Andrew Morton)
Date: Mon, 12 Nov 2001 22:39:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF04A37.29E19B1A@zip.com.au> from "Andrew Morton" at Nov 12, 2001 02:16:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163PjZ-0007NZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Corrections to speed-up the sizeing pass in Amanda:
>         * tar.h: Declare dev_null_output.
>         * buffer.c (open_archive): Detect when archive is /dev/null.
>         (flush_write): Avoid writing to /dev/null.
>         * create.c (dump_file): Do not open file if archive is being
>         written to /dev/null, nor read file nor restore times.
>         Reported by Greg Maples and Tor Lillqvist.
> 
> One wonders why.

So when you archive the file set twice (once to compute its size) its
faster. Seems sane enough. 
