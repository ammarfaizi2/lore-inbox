Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281084AbRKLWbd>; Mon, 12 Nov 2001 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRKLWbX>; Mon, 12 Nov 2001 17:31:23 -0500
Received: from zok.SGI.COM ([204.94.215.101]:64954 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281079AbRKLWbR> convert rfc822-to-8bit;
	Mon, 12 Nov 2001 17:31:17 -0500
Subject: Re: File System Performance
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF04A37.29E19B1A@zip.com.au>
In-Reply-To: <3BF03402.87D44589@zip.com.au> <3BF03402.87D44589@zip.com.au>
	<1005600431.13303.10.camel@jen.americas.sgi.com>
	<3BF04289.8FC8B7B7@zip.com.au> <9spg3c$7bb$1@penguin.transmeta.com> 
	<3BF04A37.29E19B1A@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 12 Nov 2001 16:26:32 -0600
Message-Id: <1005603992.13307.16.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-12 at 16:16, Andrew Morton wrote:

> 
> Actually, tar _is_ doing funnies with /dev/null.  Changelog says:
> 
> 1995-12-21  François Pinard  <pinard@iro.umontreal.ca>
> 
>         * buffer.c: Rename a few err variables to status.
>         * extract.c: Rename a few check variables to status.
> 
>         Corrections to speed-up the sizeing pass in Amanda:
>         * tar.h: Declare dev_null_output.
>         * buffer.c (open_archive): Detect when archive is /dev/null.
>         (flush_write): Avoid writing to /dev/null.
>         * create.c (dump_file): Do not open file if archive is being
>         written to /dev/null, nor read file nor restore times.
>         Reported by Greg Maples and Tor Lillqvist.
> 
> One wonders why.

For almost 6 years too - I suspect they optimized tar instead of
fixing the way amanda works.

Steve

