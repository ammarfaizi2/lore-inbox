Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSGRUzs>; Thu, 18 Jul 2002 16:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318340AbSGRUzs>; Thu, 18 Jul 2002 16:55:48 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:60424 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S318302AbSGRUzr>; Thu, 18 Jul 2002 16:55:47 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A78EE@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux@davidtrott.com'" <linux@davidtrott.com>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: RE: Unable to use Actiontec 56K Internal PCI Call Waiting modem w
	ith linux 2.4.19-rc2 kernel
Date: Thu, 18 Jul 2002 13:58:43 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, July 18, 2002 at 9:26 AM, linux@davidtrott.com wrote:
> 
> [1.] One line summary of the problem:
> Unable to use "Actiontec 56K Internal PCI Call Waiting modem" with 
> linux 2.4.19-rc2 kernel
> 
> [2.] Full description of the problem/report:
> 
> When I issue the following command to setup my serial port I get 
> the error:
> 
> root@delta:~# setserial /dev/ttyS2 uart 16550A port 0x9000 irq 5
> Cannot set serial info: Address already in use

... [snip] ...

> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> 
> /proc/tty/driver/serial
> serinfo:1.0 driver:5.05c revision:2001-07-08
> 0: uart:16550A port:3F8 irq:4 baud:9600 tx:0 rx:0
> 1: uart:16550A port:2F8 irq:3 baud:9600 tx:0 rx:0
> 4: uart:16550A port:9000 irq:5 baud:9600 tx:0 rx:0 CTS|DSR
> 
> ...

Hi,

Are you sure you need to use setserial on the new kernel? It looks like 
the serial driver found the modem and presented it at /dev/ttyS4. 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

