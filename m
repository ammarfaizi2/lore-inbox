Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132688AbRD1N4N>; Sat, 28 Apr 2001 09:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRD1N4E>; Sat, 28 Apr 2001 09:56:04 -0400
Received: from ns.suse.de ([213.95.15.193]:42000 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132688AbRD1Nz4>;
	Sat, 28 Apr 2001 09:55:56 -0400
Date: Sat, 28 Apr 2001 15:55:24 +0200
From: Andi Kleen <ak@suse.de>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: Ingo Molnar <mingo@elte.hu>, Fabio Riccardi <fabio@chromium.com>,
        linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space
Message-ID: <20010428155524.A30407@gruyere.muc.suse.de>
In-Reply-To: <20010428161502.I3529@niksula.cs.hut.fi> <Pine.LNX.4.33.0104281521210.10295-100000@localhost.localdomain> <20010428163030.D3682@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010428163030.D3682@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sat, Apr 28, 2001 at 04:30:30PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 04:30:30PM +0300, Ville Herva wrote:
> Yes, that's vaguely resembles what I had in mind. Of course I had no idea
> about the data structures Tux or X15 use internally, so I couldn't think it
> too thoroughly.

You can also just use the cycle counter directly in most modern CPUs. It can
be read with a single instruction.
In fact modern glibc will do it for you when you use 
clock_gettime(CLOCK_PROCESS_CPUTIME_ID, ...) 

-Andi
