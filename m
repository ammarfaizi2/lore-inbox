Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSLQOZN>; Tue, 17 Dec 2002 09:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSLQOZN>; Tue, 17 Dec 2002 09:25:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8418
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265093AbSLQOZN>; Tue, 17 Dec 2002 09:25:13 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
In-Reply-To: <Pine.LNX.4.10.10212170144030.31876-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10212170144030.31876-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 15:12:56 +0000
Message-Id: <1040137976.20018.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 09:45, Andre Hedrick wrote:
> 
> Linus,
> 
> Are you serious about moving of the banging we currently do on 0x80?
> If so, I have a P4 development board with leds to monitor all the lower io
> ports and can decode for you.

Different thing - int 0x80 syscall not i/o port 80. I've done I/O port
80 (its very easy), but requires we set up some udelay constants with an
initial safety value right at boot (which we should do - we udelay
before it is initialised)

