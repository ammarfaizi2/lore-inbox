Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279883AbRJ3Nu6>; Tue, 30 Oct 2001 08:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279947AbRJ3Nut>; Tue, 30 Oct 2001 08:50:49 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:29073 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S279883AbRJ3Nuj>;
	Tue, 30 Oct 2001 08:50:39 -0500
Message-ID: <3BDEAE67.140EB5DC@nokia.com>
Date: Tue, 30 Oct 2001 15:43:03 +0200
From: Manel Guerrero Zapata <manel.guerrero-zapata@nokia.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ext David Ford <david@blue-labs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 TCP caches ip route
In-Reply-To: <3BDDB88C.1040009@blue-labs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext David Ford wrote:
> 
> Try "ip route flush cache" or summarized, "ip r f c"
> 
> David
> 
> Manel Guerrero Zapata wrote:
> 
> >The problem seems to be that the kernel
> >caches that the device for the connexion should be dummy0.
> >If then, I cancel the telnet and start it again
> >now (of course) it stablishes a telnet conexion though the ppp0.
> >
> [snipped]

Hi,

I've tried with:
	echo 0 > /proc/sys/net/ipv4/route/flush 
ip route flush cache is equivalent to: 
	cat /proc/sys/net/ipv4/route/min_delay > /proc/sys/net/ipv4/route/flush

It does not solve anything.
I don't know why.

So not even flushing manually the cache solves
the problem.

Any ideas about why?

	Manel
