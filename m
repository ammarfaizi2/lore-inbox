Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRKMLvy>; Tue, 13 Nov 2001 06:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281610AbRKMLvo>; Tue, 13 Nov 2001 06:51:44 -0500
Received: from unthought.net ([212.97.129.24]:62906 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S281609AbRKMLv2>;
	Tue, 13 Nov 2001 06:51:28 -0500
Date: Tue, 13 Nov 2001 12:51:26 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: High UNIX socket latency
Message-ID: <20011113125126.E30421@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

One program that creates a pipe between two processes and measures
the ping/pong latency of messages between the two processes gives
me something like;

1000 iterations - ping/pong time
max =   3495 us
min =      6 us
avg = 47.212 us

In another application where I use a UNIX STREAM socket, I get
a typical latency of one send() of around 1 ms.

I cannot set TCP_NODELAY on a UNIX socket, and I can't really
see why I get the high latency.   Is there some undocumented
option like TCP_NODELAY for UNIX STREAM connections, or are there
other tricks I can play to get the latency down ?

One process does a send(), the other one does a select() and a
recv() - and the time from the send() to the recv() is around 1 ms
which I think seems far too high.

Hints, suggestions ?

 Thank you

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
