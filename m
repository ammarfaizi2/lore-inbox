Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWEUW31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWEUW31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWEUW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:29:27 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:58117 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751474AbWEUW30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:29:26 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Sam Vilain <sam@vilain.net>
Subject: Re: Linux Kernel Source Compression
Date: Sun, 21 May 2006 23:29:37 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605212257.10934.s0348365@sms.ed.ac.uk> <4470E80D.3000902@vilain.net>
In-Reply-To: <4470E80D.3000902@vilain.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605212329.37719.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 May 2006 23:22, Sam Vilain wrote:
[snip]
> Interesting.  Googling a bit;  from http://tukaani.org/lzma/benchmarks:
>
> In terms of speed, gzip is the winner again. lzma comes right behind it
> two to three times slower than gzip. bzip2 is a lot slower taking
> usually two to six times more time than lzma, that is, four to twelve
> times more than gzip. One interesting thing is that gzip and lzma
> decompress the faster the smaller the compressed size is, while bzip2
> gets slower when the compression ratio gets better.
> [...]
> neither bzip2 nor lzma can compete with gzip in terms of speed or memory
> usage.
>
> Also this:
>
> "lzmash -8" and "lzmash -9" require lots of memory and are practical
> only on newer computers; the files compressed with them are probably a
> pain to decompress on systems with less than 32 MB or 64 MB of memory.
> [...]
> The files compressed with the default "lzmash -7" can still be
> decompressed, even on machines with only 16 MB of RAM

Interesting info. I agree that LZMA is not a replacement for gzip/zlib, 
because gzip is extremely size/time efficient.

However, as noted in another thread, it is almost certainly a viable 
replacement for bzip2, since people that use bzip2 are generally interested 
in a size optimisation, not a compression speed one, and even if compression 
speed is relevant, LZMA's options scale to be approximately as good (or as 
bad??) as bzip2.

This is all fairly academic. I think the issue still boils down to widespread 
adoption; bzip2 took a while to get off the ground, people don't like messing 
with new formats, and distributors have to pick up the tools.

I think kernel.org switching formats would be one of the last things that 
could, or indeed should, happen.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
