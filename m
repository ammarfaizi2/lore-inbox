Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264585AbRFTTnN>; Wed, 20 Jun 2001 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264587AbRFTTnD>; Wed, 20 Jun 2001 15:43:03 -0400
Received: from [212.159.14.225] ([212.159.14.225]:59553 "HELO
	murphys-outbound.servers.plus.net") by vger.kernel.org with SMTP
	id <S264585AbRFTTmv>; Wed, 20 Jun 2001 15:42:51 -0400
To: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <20010615230635.A27708@lightning.swansea.linux.org.uk>
	<20010617201119.A2331@frodo.uni-erlangen.de>
	<20010619111955.B2262@frodo.uni-erlangen.de>
From: Adam Sampson <azz@gnu.org>
Organization: The Society Of People Who Repeatedly Point Out That "alot" And "allot" Are Both Wrong, And It Should Be Written "a lot"
Date: 20 Jun 2001 20:25:31 +0100
In-Reply-To: <20010619111955.B2262@frodo.uni-erlangen.de>
Message-ID: <87k827t0lw.fsf@cartman.azz.us-lot.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de> writes:

> It hung when I tried to close a browser window after reading the
> text in it for quite some time. No swapping was going on.

I've just seen this as well (for the first time) with -ac15. I was
playing music with madplay at the time, and then did a "find . -type f
-print0 | xargs -0 chmod 644" on a large directory tree on a reiserfs
partition. A few seconds after I started the command, I got a hang
which lasted a few seconds, then another, then another just after the
find finished. It hasn't happened again since.

All I got in the kernel log was:
2001-06-20 20:15:52.260230500 warning: Sound: DMA (output) timed out -
IRQ/DRQ config error?
2001-06-20 20:16:07.472837500 warning: Sound: DMA (output) timed out -
IRQ/DRQ config error?
which makes sense, since the sound paused at the same time...

Memory stats at the moment (i.e. about five minutes after it happened,
with exactly the same stuff running):

(azz:~) free
             total       used       free     shared    buffers     cached
Mem:        288240     286652       1588        196      30348     224860
-/+ buffers/cache:      31444     256796
Swap:      1048784      52176     996608
(azz:~) vmstat
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  52184   1588  30348 224876   0   2    53    62  153   400  68  10  22

.config available on request.

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
