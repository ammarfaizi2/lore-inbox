Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264443AbRFQCoP>; Sat, 16 Jun 2001 22:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264454AbRFQCoF>; Sat, 16 Jun 2001 22:44:05 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:53252
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S264443AbRFQCoC>; Sat, 16 Jun 2001 22:44:02 -0400
Date: Sat, 16 Jun 2001 23:43:52 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: <eepro100@scyld.com>
cc: <saw@saw.sw.com.sg>, <linux-kernel@vger.kernel.org>
Subject: Re: eepro100 problems with 2.2.19 _and_ 2.4.0
In-Reply-To: <Pine.LNX.4.32.0106161923290.339-100000@blackjesus.async.com.br>
Message-ID: <Pine.LNX.4.32.0106162339280.191-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just noticed:

On Sat, 16 Jun 2001, Christian Robottom Reis wrote:

> Steps to reproduce problem:
>
> * Run large ( > 2MB works ) ftp transfer in box.
> * ssh in from another box and attempt an ls -lR /

Note below:

> * 2.2.19 with Donald's eepro100.c scyld:network/
> 	Hard lock (seems to take longer to hang) - it also creates
> 	8 devices eth0-eth7!
>
> * 2.2.19 with Donald's eepro100.c fromscyld:network/test/
> 	Hard lock (pretty fast) - no multiple creation bugs

Actually, they don't hang _immediately_. They report:

eth0: Transmit timed out: status 0050  0000 at 6022/6034 commands 000c0000
000c0000 000c0000
Command 0000 was not immediately accepted, 10001 ticks!

And the ssh connection stalls but does on trying (it eventually hangs, but
not after a lot of errors are reported on the problem-box's console)

And then the box hard locks. Interesting to see that only when I run the
ssh ls -lR is that any error at all is produced. The lockups I was seeing
were all interactive use and I never really noticed if errors were showing
up or not; I just assumed they weren'.

Any help you can provide is very much appreciated. I'm about to try
Intel's drivers to see how they do.

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311

