Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270783AbRHSVLP>; Sun, 19 Aug 2001 17:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270784AbRHSVLF>; Sun, 19 Aug 2001 17:11:05 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:63503 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S270783AbRHSVKu>; Sun, 19 Aug 2001 17:10:50 -0400
Message-ID: <3B802B68.ADA545DB@bluewin.ch>
Date: Sun, 19 Aug 2001 23:11:02 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Why don't have bits the same rights as humans! (flushing to disk waiting 
 time)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently wrote some small files to the floppy disk and noticed almost nothing
happened immediately but after a certain time the floppy actually started
writing. So this action took more than 30 seconds instead just a few. This
remembered me of the elevator problem in the kernel. To transfer this example
into real live: A person who wants to take the elevator has to wait 8 hours
before the elevator even starts. While probably everyone agrees this is
ridiculous in real live astonishingly nobody complains about it in case of a disk.

Why don't have bits the same rights as humans! ;-) 

I know this waiting period should help the elevator algorithm to choose a better
service. But is this really true? Lets assume the following situations:

1. Just a few persons/time period wants to use the elevator. The elevator just
service each person since no other is waiting for its service.

2. A rather lot of persons/time period wants to use the elevator, of course the
elevator can't now service all immediately. But now since accumulation starts
the elevator can improve its service which of course reduces the accumulation
which decreases its service and so on.

3. More persons/time period than the elevator can service wants to use it, the
accumulation always gets higher. Now the elevator works as if it has been given
a large accumulation time. Hopefully this situations doesn't persist or the
system itself gets broke.

Now of course a waiting time helps to push the elevator service into situation 3
even if service request are still in situation 2 or 1. Also real elevators have
this waiting time, it's starts when the first person enters and choose his
destination until it has missed the next person (either direction or already
passed). A rough estimate gives a waiting time in the range of about an average
service time.

If I assume an average service time for bits (disk access) of about 10ms around
3000 service requests could be accumulated before any service starts. Now I dare
to question that even the best elevator algorithm is able to optimize more than
20 service requests on a usefull base, so any waiting time above 200ms is simply useless.

Lets go back to situation 2. As we see accumulation happens on a "natural" way
which imposes a certain waiting time. I guess this alone gives a service which
is at least as good as halve of the best service.

Could anybody produce any real figures to prove/disprove my theory? Could
anybody benchmark the disk access for the 3 waiting times (0, 200ms 30sec) with
different loads?

O. Wyss

Please CC, thanks.
