Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbRGGSBB>; Sat, 7 Jul 2001 14:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266516AbRGGSAl>; Sat, 7 Jul 2001 14:00:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46090 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266514AbRGGSAh>; Sat, 7 Jul 2001 14:00:37 -0400
Date: Sat, 7 Jul 2001 15:00:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <3B4748BC.D9045F12@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33L.0107071459220.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2001, Jeff Garzik wrote:

> 2) I agree that 200MB into swap and 200MB into cache isn't bad
> per se, but when it triggers the OOM killer it is bad.

Please read my patch for the OOM killer. It substracts the
swap cache from the cache figure you quote and ONLY goes
into oom_kill() if the page & buffer cache together take
less than 4% of memory (see /proc/sys/vm/{buffermem,pagecache}).

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

