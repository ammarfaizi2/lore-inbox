Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUEOSJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUEOSJL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 14:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUEOSJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 14:09:11 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:42943 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S261752AbUEOSJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 14:09:06 -0400
X-Remote-IP: 213.191.128.11
X-Remote-IP: 213.202.124.154
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, netdev@oss.sgi.com,
       jgarzik@pobox.com
Subject: Re: [PATCH] Re: ethernet/b44: Bug in b44.c:v0.93 (Mar, 2004)
 ethernet driver in 2.6.6
X-face: GK)@rjKTDPkyI]TBX{!7&/#rT:#yE\QNK}s(-/!'{dG0r^_>?tIjT[x0aj'Q0u>a
              yv62CGsq'Tb_=>f5p|$~BlO2~A&%<+ry%+o;k'<(2tdowfysFc:?@($aTGX
              4fq`u}~4,0;}y/F*5,9;3.5[dv~C,hl4s*`Hk|1dUaTO[pd[x1OrGu_:1%-lJ]W@
Organization: EINPROGRESS
X-Operating-System: GNU/Linux 2.6.5
Mail-Copies-To: never
References: <lzekpnlxwl.fsf@nimiumvax.nimium.local>
	<20040514130206.GA9583@ee.oulu.fi> <20040515120518.GA9480@ee.oulu.fi>
	<20040515121112.GA9579@ee.oulu.fi>
From: Miroslav Zubcic <mvz@nimium.com>
In-Reply-To: <20040515121112.GA9579@ee.oulu.fi> (Pekka Pietikainen's message
 of "Sat, 15 May 2004 15:11:12 +0300")
Message-ID: <lzbrkp36rr.fsf@anthea.home.int>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Date: Sat, 15 May 2004 20:07:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Pietikainen <pp@ee.oulu.fi> writes:

> On Sat, May 15, 2004 at 03:05:19PM +0300, Pekka Pietikainen wrote:
>> +	/* Enable CRC32, set proper LED modes and power on MAC */
>> +	bw32(B44_MAC_CTRL, MAC_CTRL_CRC32_ENAB | MAC_CTRL_PHY_LEDCTRL);
> Erk, that comment should of course be "power on PHY". I hate acronyms...
>
> --- linux-2.6.5-1.358/drivers/net/b44.c.orig	2004-05-15 13:59:57.000000000 +0300
> +++ linux-2.6.5-1.358/drivers/net/b44.c	2004-05-15 14:59:39.794720368 +0300
> @@ -27,8 +27,8 @@

Pekka, thank you very much for your patch. It looks like things are
working now:

dmesg part:
b44.c:v0.95 (May 15, 2004)
...
eth0: Broadcom 4400 10/100BaseT Ethernet 00:08:02:e2:2d:ba
ip_tables: (C) 2000-2002 Netfilter core team
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.

I have tried moving large packets, NFS, ping etc ... no problem
anymore, it works.

Thanks again!


-- 
		The Network is the Filesystem.

