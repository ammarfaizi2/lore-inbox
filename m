Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTICIE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTICIE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:04:26 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:53740 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261595AbTICIES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:04:18 -0400
Date: Wed, 3 Sep 2003 09:59:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kars de Jong <jongk@linux-m68k.org>
cc: Jamie Lokier <jamie@shareable.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <1062535375.3501.11.camel@kars.perseus.home>
Message-ID: <Pine.GSO.4.21.0309030958130.6985-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Sep 2003, Kars de Jong wrote:
> fikkie:/tmp# ./jamie_test
> Test separation: 4096 bytes: pass
> Test separation: 8192 bytes: pass
> Test separation: 16384 bytes: pass
> Test separation: 32768 bytes: pass
> Test separation: 65536 bytes: pass
> Test separation: 131072 bytes: pass
> Test separation: 262144 bytes: pass
> Test separation: 524288 bytes: pass
> Test separation: 1048576 bytes: pass
> Test separation: 2097152 bytes: pass
> Test separation: 4194304 bytes: pass
> Test separation: 8388608 bytes: pass
> Test separation: 16777216 bytes: pass
> VM page alias coherency test: all sizes passed
> 
> New program:
> 
> fikkie:/tmp# time ./jamie_test2
> (2048) [10000,10000,0] Test separation: 4096 bytes: pass
> (2048) [10000,10000,0] Test separation: 8192 bytes: pass
> (2048) [10000,10000,0] Test separation: 16384 bytes: pass
> (2048) [10000,10000,0] Test separation: 32768 bytes: pass
> (2048) [10000,10000,0] Test separation: 65536 bytes: pass
> (2048) [10000,10000,0] Test separation: 131072 bytes: pass
> (2048) [10000,10000,0] Test separation: 262144 bytes: pass
> (2048) [10000,10000,0] Test separation: 524288 bytes: pass
> (2048) [10000,10000,0] Test separation: 1048576 bytes: pass
> (2048) [10000,10000,0] Test separation: 2097152 bytes: pass
> (2048) [10000,10000,0] Test separation: 4194304 bytes: pass
> (2048) [10000,10000,0] Test separation: 8388608 bytes: pass
> (2048) [10000,10000,0] Test separation: 16777216 bytes: pass
> VM page alias coherency test: all sizes passed
>                                                                                 
> real    1m51.210s
> user    1m44.950s
> sys     0m4.930s
> fikkie:/tmp# cat /proc/cpuinfo
> CPU:            68020
> MMU:            68851
> FPU:            68881
> Clocking:       15.6MHz
> BogoMips:       3.90
> Calibration:    19520 loops
> fikkie:/tmp#

So the store buffer is coherent on 68020 with external MMU, while it isn't on
68040 with internal MMU...

Now all that's left is the 68030.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

