Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131056AbRCTWVg>; Tue, 20 Mar 2001 17:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRCTWV1>; Tue, 20 Mar 2001 17:21:27 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12299 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131056AbRCTWVR>; Tue, 20 Mar 2001 17:21:17 -0500
Date: Tue, 20 Mar 2001 19:18:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Josh Grebe <squash@primary.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Question about memory usage in 2.4 vs 2.2
In-Reply-To: <Pine.LNX.4.21.0103201403440.2405-100000@scarface.primary.net>
Message-ID: <Pine.LNX.4.21.0103201857170.3750-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Josh Grebe wrote:

> slabinfo reports:
> 
> inode_cache       189974 243512    480 30439 30439    1 :  124   62
> dentry_cache      201179 341940    128 11398 11398    1 :  252  126
                                      ^
  <name>            <used> <allocd>   |  <used> <allocd>
                     <in objects>  <size>   <in pages>

> However, I am hard pressed to find documentation on how to actually
> read this data, especially on a SMP box. Could someone give me a brief
> runwdown?

See above. The columns further to the right are debugging info.

> Also, if this memory is cached, wouldn't it make sense if it were
> reported as part of the total cached memory in /proc/meminfo?

I'd definately like to see this. It would be great if somebody
would sit down and implement this.   <hint> <hint>

> And can this behavior be tuned so that it uses less of the overall
> memory?

This isn't currently possible. Also, I suspect what we really want
for most situations is a way to better balance between the different
uses of memory.  Again, patches are welcome (I haven't figured out a
way to take care of this balancing yet ... maybe we DO want some way
of limiting memory usage of each subsystem??).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

