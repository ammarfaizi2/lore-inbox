Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271619AbRHZXY5>; Sun, 26 Aug 2001 19:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271623AbRHZXYi>; Sun, 26 Aug 2001 19:24:38 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:10935 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S271619AbRHZXYZ>;
	Sun, 26 Aug 2001 19:24:25 -0400
Date: Mon, 27 Aug 2001 01:24:39 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010827012439.D6755@cerebro.laendle>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva> <20010826172310Z16216-32383+1477@humbolt.nl.linux.org> <20010826211847.B2994@cerebro.laendle> <20010826210026Z16294-32383+1508@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010826210026Z16294-32383+1508@humbolt.nl.linux.org>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 11:07:07PM +0200, Daniel Phillips <phillips@bonn-fries.net> wrote:
> To recap, you made these changes:
> 
>   - Changed to -ac
>   - Set max-readahead through proc
> 
> Anything else?  Did you change MAX_SECTORS?

no, I tinkered a lot with my server (freeing up memory), which obviously
helped somewhat and increased socket buffers to 256k max., makeing i/o
more chunky and thus more efficient. i also use more than one reader
thread: under linus' kernels more than one thread made the situation
worse, on the ac kernels they seem to slightly improve throughout, up to a
point.

> > no longer thrashing. And linux does the job nicely ;)
> Good, but should we rest on our laurels now?

well, linux-2.4 has a lot of dark corners that need improving, but the
machine does no longer totally misbehave (4 or 5 mb/s is debatable, but
2mb/s with more memory and higher load is not ;). it's now acceptable to
me ;)


-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
