Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277844AbRJIRKF>; Tue, 9 Oct 2001 13:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277848AbRJIRJz>; Tue, 9 Oct 2001 13:09:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:45069 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277844AbRJIRJq>;
	Tue, 9 Oct 2001 13:09:46 -0400
Date: Tue, 9 Oct 2001 14:10:00 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Till Immanuel Patzschke <tip@internetwork-ag.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Q] cannot fork w/ 1000s of procs (but still mem avail.)
In-Reply-To: <3BC32117.52E68787@internetwork-ag.de>
Message-ID: <Pine.LNX.4.33L.0110091408470.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Till Immanuel Patzschke wrote:

> hopefully a simple question to answer: I get "cannot fork" messages on
> my machine running some 20000 processes and threads (1 master proc, 3
> threads), where each (master) process opens a socket and does IP
> traffic over it. Although there is plenty of memory left (4GB box, 2GB
> used, 0 swap), I get "cannot fork - out of memory" when trying to
> increase the number of procs. (If none of the procs does IP, I can
> start more [of course?!].) Anything I can do to increase the number of
> active processes using IP? Any kernel paramter, limit, sizing?

For efficiency reasons, the kernel and userspace have to share
the same 4GB virtual address area. By default this area is split
3:1, with 3GB virtual space available for user programs and 1GB
for the kernel.

I suspect in your case it may be worth it to change the kernel
to use 2GB of virtual address space for itself and only let
userspace have 2GB...

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

