Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131873AbRCVVCi>; Thu, 22 Mar 2001 16:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131891AbRCVVC3>; Thu, 22 Mar 2001 16:02:29 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:60365 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131873AbRCVVCQ>; Thu, 22 Mar 2001 16:02:16 -0500
Date: Thu, 22 Mar 2001 22:01:30 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Stephen Clouse <stephenc@theiqgroup.com>
Cc: Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010322220130.G11126@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva> <20010322124727.A5115@win.tue.nl> <20010322142831.A929@owns.warpcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010322142831.A929@owns.warpcore.org>; from stephenc@theiqgroup.com on Thu, Mar 22, 2001 at 02:28:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 02:28:31PM -0600, Stephen Clouse wrote:
[Another OOM-Killing thread] 
> It would be nice to give immunity to certain uids, or better
> yet, just turn the damn thing off entirely.  I've already
> hacked that in...errr, out.

That's fine and suits best for all.

I have provided an API for installing such OOM handlers (and have
provided even an simple example for using it).

See http://www.tu-chemnitz.de/~ioe/oom-kill-api/index.html for
details.

It applies to all regular kernels and with some offsets even to
ac20. So this is the way to go for custom OOM handling. 

Rik noted once, that not much research has been done yet on this
topic and that he is certain, that his code cannot cover all
cases.

Linus on the other hand doesn't like the idea of 'plugins' for
core kernel code. 

So this patch is the best thing, that can be done about the
situation.

All work should be based on it, since it allows customers and
researchers, that LIKE to try such 'plugins' to try all of them
instead of having to patch and recompile the kernel for every OOM
handler available.

I would LOVE to start a link collection for all OOM handlers
based on my patch or even host them, IF they are implemented as
modules (as suggested by my API). This should avoid duplicate
effort of this.

Of course I hope to satisfy all needs by this. I'm also willing
to include any API changes (read: exported functions, structs and
variables) necessary for some OOM handlers in my patch.

Thanks & Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
