Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSIZNLA>; Thu, 26 Sep 2002 09:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSIZNLA>; Thu, 26 Sep 2002 09:11:00 -0400
Received: from mx0.gmx.net ([213.165.64.100]:12589 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S261173AbSIZNK7>;
	Thu, 26 Sep 2002 09:10:59 -0400
Date: Thu, 26 Sep 2002 15:16:10 +0200 (MEST)
From: Marco Schwarz <marco.schwarz@gmx.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <200209261258.g8QCwpp04301@Port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Serious Problems with diskless clients
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0012086198@gmx.net
X-Authenticated-IP: [153.95.95.95]
Message-ID: <26619.1033046170@www51.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 26 September 2002 08:26, Marco Schwarz wrote:
> > Hi all,
> >
> > my diskless clients have some severe problems on one of my servers.
> > Sometimes (right now most of the time) everything just hangs at the same
> > place when starting up the kernel. Here are the last messages I get
> (right
> > before this IP-Config is running and looks OK):
> >
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
> > ds: no socket drivers loaded !
> > Looking up port of RPC 100003/2 on 192.168.0.235
> > portmap: server 192.168.0.235 mot responding, timed out !
> 
> Hook another box to the same network segment and run
> ping or mtr to 192.168.0.235 and to the booting box.
> Maybe your net drops packets or otherwise misbehaves.
> 
> BTW, 2.4.10 is way too old. 
> I don't see "mot responding, timed out !" in 2.4.19
> source, rather "not responding, timed out".
> --
> vda
> 

"mot responding" is just a typo, I had to type all the messages from screen
;-)

I already tried pinging, works in both directions. On the server I start
portmap now with 'portmap -v' and I am able to see the requests from the client:


'connect from 192.168.0.87 to getport(nsf)'
'connect from 192.168.0.87 to getport(mountd)'

I also see some messages from Portmap which look like this:

'connect from 192.168.0.87 to dump()'

I also have to note that I have 2 NICs in this server, one with adress
153.95.240.x and one with 192.168.0.x.

Problems seem to occur only on the 192.168.0.x network (I already
interchanged adresses between cards, no effect).

BTW: Is there a newer version of portmap than 5.1 ? I wonder if this is
maybe related to portmap ...

Regards,
Marco

