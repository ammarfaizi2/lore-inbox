Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269966AbRHJSac>; Fri, 10 Aug 2001 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269968AbRHJSaW>; Fri, 10 Aug 2001 14:30:22 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:31752 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269966AbRHJSaI>; Fri, 10 Aug 2001 14:30:08 -0400
Message-ID: <3B742996.3F2C8DEC@zip.com.au>
Date: Fri, 10 Aug 2001 11:36:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Subba Rao <subba9@home.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Half Duplex and Zero Copy IP
In-Reply-To: <20010810095313.A6219@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subba Rao wrote:
> 
> Hello,
> 
> I have 2 3Com NICs on my system. They are 3c905C Tornado PCI cards.
> The drivers are compiled into the kernel (Slackware 8.0 with kernel 2.4.7).
> 
> One of the interfaces will be used as a sniffer interface (without IP address)
> and a very high traffic pipes. I do not wish to loose any packets coming to this
> interface. Is it better if I initialize the interface in HALF DUPLEX mode? If yes,
> how do I set the card to HALF DUPLEX mode? How can I find out the HW (NIC) settings
> on the system?

No, this will provide no benefit.

> Another question about 3Com NICs, do they perform zero-copy IP?

Linux's zerocopy infrastructure allows the sendfile() system call
to save a copy with NICs which have hardware checksumming and
scatter/gather.  3c905C is one such NIC.  Kernel is not generally
"zero copy", but large savings are available in certain situations.
NFS packet reassembly benefits from 905C's as well.

> I read that the performance improves a lot WITHOUT zero-copy IP.

Not right.  Where did you read that?

-
