Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbTAUH6h>; Tue, 21 Jan 2003 02:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTAUH6h>; Tue, 21 Jan 2003 02:58:37 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:33936
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266478AbTAUH6g>; Tue, 21 Jan 2003 02:58:36 -0500
Date: Tue, 21 Jan 2003 03:07:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Alan <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function_mask
In-Reply-To: <3E2CF327.8030107@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0301210304210.2653-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Manfred Spraul wrote:

> from 2.5.52, <asm-i386/atomic.h>
>     #define atomic_read(v)          ((v)->counter)
> AFAIK atomic_read never contained locked bus cycles.
> 
> Btw, Zwane, what about removing non_atomic from the prototype?

The funny thing is, there are about 3 different versions of 
smp_call_function and removing nonatomic would reduce the argument count 
(there are some architectures which use 'retry' in nonatomic's place) and 
i'm a bit wary of making other archs bend over for i386 these days. 
Perhaps renaming it to __unused or something similarly obvious.

	Zwane

-- 
function.linuxpower.ca

