Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266136AbRF2RxQ>; Fri, 29 Jun 2001 13:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbRF2RxF>; Fri, 29 Jun 2001 13:53:05 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:24526 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S266132AbRF2Rwo>; Fri, 29 Jun 2001 13:52:44 -0400
Message-ID: <3B3CC111.5F53C7CD@kegel.com>
Date: Fri, 29 Jun 2001 10:55:29 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: darx_kies@gmx.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: CLOSE_WAIT Problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chriss wrote:
> I wrote a simple server application and installed it on a linux machine
> in Slovakia, running Mandrake 7.2 (2.2.18).
> That machine loses tcp/ip packages, as it uses a Microwave connection.
> So my server works all the time, and the tcp/ip connections are set to
> TIME_WAIT, but after a couple of hours
> my server application won't get any connections anymore and the netstat
> shows a lot of CLOSE_WAITs that belong to the server.
> I've installed the same server on two SuSE 7.1 (2.2.18) machines in
> Austria, and the problem never occured.
> So does anyone know how to avoid that CLOSE_WAITs, or at least how to
> get rid of  them?

Dunno if this will help, but:

They're supposed to go away by themselves after 2MSL (about 120 seconds).
Other people (on many operating systems) have reported similar problems, btw:

http://uwsg.iu.edu/hypermail/linux/net/9611.2/0043.html
http://www.sunmanagers.org/pipermail/sunmanagers/2001-April/002894.html
http://www2.real-time.com/tclug-list/1999/Jun/msg00254.html
http://mail-index.netbsd.org/netbsd-bugs/1996/04/16/0004.html

The last one has a fix for an old bug in netbsd that could cause this.
- Dan
