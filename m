Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314136AbSEDPpx>; Sat, 4 May 2002 11:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314239AbSEDPpw>; Sat, 4 May 2002 11:45:52 -0400
Received: from relay1.pair.com ([209.68.1.20]:27411 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S314136AbSEDPpw>;
	Sat, 4 May 2002 11:45:52 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD402D2.E3A94CA2@kegel.com>
Date: Sat, 04 May 2002 08:48:34 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: khttpd newbie problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having an oops with khttpd on an embedded 2.4.17 ppc405
system, so I thought I'd try it out on my pc.  But I can't
get khttpd to serve any requests.

I built khttpd into the kernel with vanilla 2.4.17smp on 
Intel on Red Hat 7.2, then turned it on as follows:

echo /home/dank/stress > /proc/sys/net/khttpd/documentroot
echo 80 > /proc/sys/net/khttpd/serverport
echo 8000 > /proc/sys/net/khttpd/maxconnect
echo 1 > /proc/sys/net/khttpd/start

I also made sure there was an index.html in /home/dank/stress,
turned off the firewall, did /etc/init.c/ipchains restart,
and made sure netstat reported port 80 as listening.

But... when I try to fetch http://localhost/index.html,
it just sits there.  Likewise, when I telnet to port 80,
even from a different machine, it just accepts bytes forever; 
no matter what I type, it just echoes the bytes right back at me.

If I do
echo 1 > /proc/sys/net/khttpd/stop
port 80 stops listening, and any open connections are closed.

I must be doing something silly... surely khttpd works?
Is it because I'm running SMP, perhaps?
- Dan
