Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279894AbRJ3JF5>; Tue, 30 Oct 2001 04:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279899AbRJ3JFs>; Tue, 30 Oct 2001 04:05:48 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:3059 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S279894AbRJ3JFh>;
	Tue, 30 Oct 2001 04:05:37 -0500
Message-ID: <3BDE6BAB.F7100545@nokia.com>
Date: Tue, 30 Oct 2001 10:58:19 +0200
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


Answering to David:

Well, I have not tried that yet. But that is not a real solution.
You are not supposed to be flushing the cache manualy
(Although it might work as kind of workaround)
the kernel should detect that this is a stale cached entry
and delete it.


Answering to Martin:

Sure for most of the people that's not a big deal.
And yes, you are right: if the tcp connection has
been stablished before playing with routing tables
then everything works just fine.

But, IMHO I thing TCP should not make any assumptions about
routing tables (not even during the stablishment of connection).
So, I personaly see this as a kernel bug.

I understand that this is an "optimization" of the kernel
code, but I thing you should have the possibility of
disabling it.


Regards,

        Manel Guerrero
