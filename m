Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRE3PFE>; Wed, 30 May 2001 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRE3PEy>; Wed, 30 May 2001 11:04:54 -0400
Received: from Firewall.oeone.com ([216.221.199.130]:43531 "HELO
	mail.oeone.com") by vger.kernel.org with SMTP id <S261274AbRE3PEn>;
	Wed, 30 May 2001 11:04:43 -0400
Message-ID: <3B150DC8.2020505@oeone.com>
Date: Wed, 30 May 2001 11:12:08 -0400
From: Masoud Sharbiani <masouds@oeone.com>
Organization: OEone Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; rv:0.9) Gecko/20010516
X-Accept-Language: en
MIME-Version: 1.0
To: james@spunkysoftware.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creative 4-speed CDROM driver
In-Reply-To: <E154VOJ-0003cy-00@the-village.bc.nu> <004601c0e811$f8c93d80$c1a5fea9@spunky> <20010529122109.A5196@se1.cogenit.fr> <015601c0e8de$0e936ba0$c1a5fea9@spunky> <20010530094004.A14129@se1.cogenit.fr> <000501c0e92c$efb19780$c1a5fea9@spunky>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james@spunkysoftware.com wrote:

> You see, I can't even begin to write one line of code, because I know
> nothing about what I am supposed to do. Sure, I know the basics, I have
> written toy device drivers for Linux, I know how to implement a driver for
> Minix, understand the main loop, handling messages from the Minix kernel,
> how to fill in a device structure correctly with pointers to functions that
> implement the device independant interface, etc. I know this stuff, that's
> not a problem. My problem is what is the I/O address range? Can I access it
> in C? Do I use DMA? When there are commands that can be implemented (set A,
> I'll call them) and another set of functions when the device uses the ATA
> Packet Interface (I'll call them set B) then which set? And the standard of
> ATAPI makes it clear that the Packet Interface is elsewhere, not defined in
> the ATAPI document.


I've got some suggestions for you.
First: be humble (sorry, I don't want to offend you at all) read the 
LKML FAQ. the address is at the very end of this email. it would give 
you the pointers you want. (including books/web pages).

second: bear in mind that Linux driver structure is not like minix. 
minix is Micro kernel, Linux is not. therefore, there is no main loop 
here. you just register the required device specific operations and you 
will receive all open/read/write/ioctl/close requests. (pls. See the 
design of Unix operating system for more information).

third: look for a similar device driver implementation in kernel (well, 
it is learning in the hard way :-) ) .

Good luck,

Masoud

