Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283925AbRLEKI5>; Wed, 5 Dec 2001 05:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283926AbRLEKIs>; Wed, 5 Dec 2001 05:08:48 -0500
Received: from sun.fadata.bg ([80.72.64.67]:10504 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S283925AbRLEKIa>;
	Wed, 5 Dec 2001 05:08:30 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: "David S. Miller" <davem@redhat.com>, Martin.Bligh@us.ibm.com,
        riel@conectiva.com.br, lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
In-Reply-To: <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com>
	<2457910296.1007480257@mbligh.des.sequent.com>
	<20011204163646.M7439@work.bitmover.com>
	<20011204.183601.22018455.davem@redhat.com>
	<20011204192317.N7439@work.bitmover.com>
From: Momchil Velikov <velco@fadata.bg>
Date: 05 Dec 2001 10:12:36 +0200
In-Reply-To: <20011204192317.N7439@work.bitmover.com>
Message-ID: <87snaqf5l7.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Larry" == Larry McVoy <lm@bitmover.com> writes:
Larry>    Where this approach wins big is everywhere except the page cache.  Every
Larry>    single data structure in the system becomes N-way more parallel -- with
Larry>    no additional locks -- when you boot up N instances of the OS.  That's

I was wondering about multiple OS instances in their own address
space. What's the need for separate address spaces for the kernels ?

It looks more natural to me to _actually_ have N instances of kernel
data structures in the _same address space_, i.e. turning
each global variable into an array_ indexed by an "instance id",
much in the same way as we have now per-CPU structures. Well,
I don't actually think it would be as simple as stated above, I'm just
proposing it as a general approach towards ccclustering.

(btw, there was some discussion on #kernelnewbies, on Nov 12th and
21st, you can find the logs here
http://vengeance.et.tudelft.nl/~smoke/log/kernelnewbies/2001-11/)


Regards,
-velco

