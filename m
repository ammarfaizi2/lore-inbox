Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbRCCADz>; Fri, 2 Mar 2001 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130172AbRCCADp>; Fri, 2 Mar 2001 19:03:45 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:12229
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S130167AbRCCADc>; Fri, 2 Mar 2001 19:03:32 -0500
Date: Sat, 3 Mar 2001 01:03:26 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@io.fachschaften.tu-muenchen.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Adam Sampson <azz@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VM balancing problems under 2.4.2-ac1
In-Reply-To: <Pine.LNX.4.31.0102232120531.8568-100000@localhost.localdomain>
Message-ID: <Pine.NEB.4.33.0103030053070.14582-100000@io.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Rik van Riel wrote:

> On 23 Feb 2001, Adam Sampson wrote:
>
> > The VM balancing updates in the recent ac kernels seem to have caused
> > some interesting performance problems on my desktop machine. I've got
> > 160Mb of RAM, and 2.4.2-ac1 appears to be using excessively large
> > amounts of it for buffers and cache while pushing stuff out to
> > swap. This means that Mozilla, for instance, runs significantly worse
> > than under 2.4.0, since bits of it are being swapped in and out.
>
> This is a known problem which I'll fix as soon as I have a
> solution.
>
> The problem is that we still have no good way to balance
> how much memory we take from the cache and how much memory
> we take from processes.

I have the same problem Adam has: I'm running 3-5 applications on my
computer. I have 64 MB of RAM and I use usually less than 50 MB. I have
swap for the rare cases where I need more RAM than I have. But with
2.4.x-acyz kernels I do often have to wait several seconds after I
switched to another running application before it's swapped in again
because it seems this application was swapped out to cache some MP3 I
surely won't listen to before the next reboot...

> This means that for some workloads we'll be evicting too
> much cache while for other workloads we'll be evicting too
> much process pages...
>
> If anybody as a good idea to make this code auto-balancing,
> please let me know.

I have no idea for auto-balancing but another idea: It's one possibility
to let the user choose when doing "make *config" what he wants:

- A VM optimized for servers that swaps out applications in favor of
  caching.
or
- A VM optimized for workstations that won't swap out applications in
  favor of caching.


I know that's not a perfect solution but it would make the situation much
better.


> regards,
>
> Rik

cu
Adrian

-- 

Nicht weil die Dinge schwierig sind wagen wir sie nicht,
sondern weil wir sie nicht wagen sind sie schwierig.

