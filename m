Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRHKL6X>; Sat, 11 Aug 2001 07:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbRHKL6N>; Sat, 11 Aug 2001 07:58:13 -0400
Received: from cc885639-a.flushing1.mi.home.com ([24.182.96.34]:34323 "HELO
	caesar.lynix.com") by vger.kernel.org with SMTP id <S267233AbRHKL6H>;
	Sat, 11 Aug 2001 07:58:07 -0400
Date: Sat, 11 Aug 2001 07:59:06 +0000
From: Subba Rao <subba9@home.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Half Duplex and Zero Copy IP
Message-ID: <20010811075905.A32210@home.com>
Reply-To: Subba Rao <subba9@home.com>
In-Reply-To: <20010810095313.A6219@home.com> <3B742996.3F2C8DEC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B742996.3F2C8DEC@zip.com.au>; from akpm@zip.com.au on Fri, Aug 10, 2001 at 11:36:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  0, Andrew Morton <akpm@zip.com.au> wrote:
> Subba Rao wrote:
> > 
> > Hello,
> > 
> > I have 2 3Com NICs on my system. They are 3c905C Tornado PCI cards.
> > The drivers are compiled into the kernel (Slackware 8.0 with kernel 2.4.7).
> > 
> > One of the interfaces will be used as a sniffer interface (without IP address)
> > and a very high traffic pipes. I do not wish to loose any packets coming to this
> > interface. Is it better if I initialize the interface in HALF DUPLEX mode? If yes,
> > how do I set the card to HALF DUPLEX mode? How can I find out the HW (NIC) settings
> > on the system?
> 
> No, this will provide no benefit.

So, is the card set in half-duplex mode by default and full-duplex is a forced
option?

> 
> > Another question about 3Com NICs, do they perform zero-copy IP?
> 
> Linux's zerocopy infrastructure allows the sendfile() system call
> to save a copy with NICs which have hardware checksumming and
> scatter/gather.  3c905C is one such NIC.  Kernel is not generally
> "zero copy", but large savings are available in certain situations.
> NFS packet reassembly benefits from 905C's as well.
> 
> > I read that the performance improves a lot WITHOUT zero-copy IP.
> 
> Not right.  Where did you read that?
> 
	http://www.fefe.de/linuxeth/

"To achieve gigabit throughput, it is important that the operating system does 
not copy the data in the packets before sending them (this is called zero-copy 
IP). Unfortunately, the kernel needs to put a header before the data in the
packet, so not copying the data to a buffer in kernel space means that the NIC
needs to be able to fetch the header from a different place in memory than the
user data in the packet. This is called scatter/gather and is necessary for
zero-copy IP." 

-- 

Subba Rao
subba9@home.com
http://members.home.net/subba9/

GPG public key ID 27FC9217
Key fingerprint = 2B4C 498E 1860 5A2B 6570  5852 7527 882A 27FC 9217
