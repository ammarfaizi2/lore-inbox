Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSDVHXA>; Mon, 22 Apr 2002 03:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314079AbSDVHW7>; Mon, 22 Apr 2002 03:22:59 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:55429 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314078AbSDVHW6>; Mon, 22 Apr 2002 03:22:58 -0400
Date: Mon, 22 Apr 2002 09:21:34 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: "Sean Rima" <fido@tcob1.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c509 problem in 2.4.3
Message-Id: <20020422092134.03de8142.kristian.peters@korseby.net>
In-Reply-To: <MSGID_2=3a263=2f950_14789c87@fidonet.org>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.18-ac3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sean Rima" <fido@tcob1.net> wrote:
> I use a 3Com 3c509 which I have used okay under 2.2.20. However when I compiled abd installed 2.4.18, the card was no longer available. The card was installed via the 3Com utilty disk, and auto set, 
> which gave it settings of io 0x210 and IRQ 10. To use under 2.4.18 I have to boot dos, change it to io 0x200 and irq 7.
> 
> Okay, this is not major but I have heard of others having problems with the 3c509 driver.

I've never seen problems with the driver. Have you tried to pass some parameters like io=0x200 irq=10 to insmod when loading the module ? The only thing known to all isa cards is autodetection.

net-modules.txt sais:

3c509.c:
	io = 0
	irq = 0
	( Module load-time probing Works reliably only on EISA, ISA ID-PROBE
	  IS NOT RELIABLE!  Compile this driver statically into kernel for
	  now, if you need it auto-probing on an ISA-bus machine. )

Or put something like that to your modules.conf:

options 3c509 io=0x200 irq=10

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
