Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTLERT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbTLERT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:19:59 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:53001 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S263922AbTLERT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:19:58 -0500
Date: Sat, 6 Dec 2003 04:19:04 +1100 (EST)
From: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Alsa oops, 2.6.0-test8
In-Reply-To: <E1ARV0L-0000SV-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.53.0312060415290.16360@tellurium.ssi.swin.edu.au>
References: <E1ARV0L-0000SV-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Herbert Xu wrote:

> Tim Connors <tconnors+linuxkernel031203@astro.swin.edu.au> wrote:
> >
> > Nov 25 23:32:46 bohr kernel: Call Trace:
> > Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+944957/1760761] resample_expand+0x259/0x320 [snd_pcm_oss]
>
> This is a known gcc 3.3 bug triggered by ALSA.
>
> Either use gcc 2.95/3.2 or enable CONFIG_FRAME_POINTER.

Yep, thanks. Verified under 2.6.0-test11 (the oops was even stranger than
test8 - it seemed to get into a long loop of oopses from all over the
kernel before the mouse pointer finally gave up the ghost)

My gcc-3.3 version was:
Source: gcc-3.3 (1:3.3.2ds5-4)
Version: 1:3.3.2-4

CONFIG_FRAME_POINTER fixed (papered over) the gcc bug :)


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Hacking's just another word for nothing left to kludge.
