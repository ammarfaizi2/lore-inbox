Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVFOVaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVFOVaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVFOV26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:28:58 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:43023 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261588AbVFOV1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:27:55 -0400
Message-ID: <42B09D49.4090505@tuxrocks.com>
Date: Wed, 15 Jun 2005 15:27:37 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Leber <christian@leber.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/2] lzma support: lzma compressed kernel image
References: <20050607214128.GB2645@core.home> <20050612223150.GA26370@core.home> <42AE3C91.4090904@tuxrocks.com> <20050614103135.GA4319@core.home>
In-Reply-To: <20050614103135.GA4319@core.home>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christian Leber wrote:
> On Mon, Jun 13, 2005 at 08:10:25PM -0600, Frank Sorenson wrote:
>>patches appear to work as advertised.
> 
> I don't like the moving of the initrd, but i don't know another way to
> get it working otherwise.
> 
>>lzma reduced my kernel by
>>approximately 25%, so I'd say it looks promising.
> 
> 25%? i would have expected a smaller saving

- -rw-r--r--   1 root root  2959194 Jun 12 14:28 vmlinuz-2.6.12-rc6-fs1
- -rw-r--r--   1 root root  2192674 Jun 13 21:47 vmlinuz-2.6.12-rc6-fs2

> How to obtain should be enough, i'll add it.

Great, thanks.

>>- - Detect that the lzma application isn't present, and fall back to gzip
>>(with a warning) if lzma fails.
> 
> No.
> If you select lzma you have to have it, you also don't download a
> compiler when somebody tries to compile the kernel without a compiler.

Uhm, no, I wasn't saying that.  Just suggesting a simple failsafe.  It's not important.

>>- - If we can embed the decompressor into the boot-time kernel, can't we
>>put a compressor into the kernel source, and avoid the need for the
>>external program?
> 
> How do think will people react to a hundreds of kb sized C++ patch that
> is not - i repeat - NOT in proper coding style?

I wasn't suggesting that we include the entire source code as-is.  Just that if we can include the decompressor in < 45K of code, surely the compression could be included easily.  Again, it's not very important.  Giving enough information to build and run is most important.

Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCsJ1JaI0dwg4A47wRAlu8AJ4svae4WhrMnZf8HRNJl0PBCsTaXACeIhIa
8rmljN+/ZG1Vtg5OPa5KSAc=
=rOJl
-----END PGP SIGNATURE-----
