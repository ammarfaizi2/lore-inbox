Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131415AbRCOM6P>; Thu, 15 Mar 2001 07:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131683AbRCOM6G>; Thu, 15 Mar 2001 07:58:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:28168 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131415AbRCOM5e>; Thu, 15 Mar 2001 07:57:34 -0500
Date: Thu, 15 Mar 2001 09:32:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mårten Wikström <Marten.Wikstrom@framfab.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: How to optimize routing performance
In-Reply-To: <E6D22E487D45D411931B00508BCF93E75C0326@storeg001.framfab.se>
Message-ID: <Pine.LNX.4.21.0103150929080.4165-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, [ISO-8859-1] Mårten Wikström wrote:

> I've performed a test on the routing capacity of a Linux 2.4.2 box
> versus a FreeBSD 4.2 box. I used two Pentium Pro 200Mhz computers with
> 64Mb memory, and two DEC 100Mbit ethernet cards. I used a Smartbits
> test-tool to measure the packet throughput and the packet size was set
> to 64 bytes. Linux dropped no packets up to about 27000 packets/s, but
> then it started to drop packets at higher rates. Worse yet, the output
> rate actually decreased, so at the input rate of 40000 packets/s
> almost no packets got through. The behaviour of FreeBSD was different,
> it showed a steadily increased output rate up to about 70000 packets/s
> before the output rate decreased. (Then the output rate was apprx.
> 40000 packets/s).

> So, my question is: are these figures true, or is it possible to
> optimize the kernel somehow? The only changes I have made to the
> kernel config was to disable advanced routing.

There are some flow control options in the kernel which should
help. From your description, it looks like they aren't enabled
by default ...

At the NordU/USENIX conference in Stockholm (this february) I
saw a nice presentation on the flow control code in the Linux
networking code and how it improved networking performance.
I'm pretty convinced that flow control _should_ be saving your
system in this case.

OTOH, if they _are_ enabled, the networking people seem to have
a new item for their TODO list. ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

