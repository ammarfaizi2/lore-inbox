Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWEUWWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWEUWWV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWEUWWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:22:21 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:26001 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932195AbWEUWWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:22:20 -0400
Message-ID: <4470E80D.3000902@vilain.net>
Date: Mon, 22 May 2006 10:22:05 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <20060521210056.GA3500@taniwha.stupidest.org> <4470DEC4.6050308@vilain.net> <200605212257.10934.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605212257.10934.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>>Exactly, and while I know my network connection isn't exactly
>>representative of the general population of people building the kernel,
>>it's currently faster for me to download and unpack a .gz than to wait
>>the extra time for bzip2 to decompress. I've always found it quicker
>>dealing with .gz's for incremental patches. I thought the speed issue is
>>more of a speed / compression ratio trade-off, ie a caveat of
>>compression in general.
>>    
>>
>
>Actually, you're making false assumptions about LZMA. It is in fact quicker to 
>decompress than bzip2, which largely addresses this issue. Compression speeds 
>are the problem, but the end user won't do a lot of that.
>

Interesting.  Googling a bit;  from http://tukaani.org/lzma/benchmarks:

In terms of speed, gzip is the winner again. lzma comes right behind it
two to three times slower than gzip. bzip2 is a lot slower taking
usually two to six times more time than lzma, that is, four to twelve
times more than gzip. One interesting thing is that gzip and lzma
decompress the faster the smaller the compressed size is, while bzip2
gets slower when the compression ratio gets better.
[...]
neither bzip2 nor lzma can compete with gzip in terms of speed or memory
usage.

Also this:

"lzmash -8" and "lzmash -9" require lots of memory and are practical
only on newer computers; the files compressed with them are probably a
pain to decompress on systems with less than 32 MB or 64 MB of memory.
[...]
The files compressed with the default "lzmash -7" can still be
decompressed, even on machines with only 16 MB of RAM

Sam.
