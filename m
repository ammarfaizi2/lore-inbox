Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318997AbSHMUDM>; Tue, 13 Aug 2002 16:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319008AbSHMUDM>; Tue, 13 Aug 2002 16:03:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52749 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318997AbSHMUDL>;
	Tue, 13 Aug 2002 16:03:11 -0400
Message-ID: <3D5966E6.8060500@mandrakesoft.com>
Date: Tue, 13 Aug 2002 16:07:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nandakumar NarayanaSwamy <nanda_kn@rediffmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 8139too.c problems
References: <20020813104232.29562.qmail@mailweb34.rediffmail.com>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nandakumar NarayanaSwamy wrote:
> Resending the mail, since i have not received a copy of that...
> Sorry if ypu are receiving duplicate copies.
> 
> 
> Hi All,
> 
> Sorry for disturbing the list again.
> 
> I am using RTL8139C in our target board which is based on MIPS
> IDT32334 processor.
> 
> The version of 8139too.c that i am using is 1.0.1 where as I am
> using a embedded linux which is based on Linux Kernel
> 2.4.5-pre1.
> 
> When the packet is transmitted out, it is coming out as all
> 0's(captured using sniffer). I dumped the whole packet in
> rtl8139_start_xmit (). The packet is a valid ARP packet.
> 
> My doubt is whether this 8139too.c is tested with MIPS processors?
> Because in one of the article i found that the supported
> processors are ARM, i386 etc.


8139too has been tested on big-endian and little-endian, 32-bit and 
64-bit processors without showing the behavior you're seeing.

If the packet is fine in rtl8139_start_xmit, it sounds like a hardware 
problem.  There is certainly the possibility that your platform is 
interacting poorly in some way with the driver, but that's a slim 
possibility.  There's no way to know more without you doing some testing 
and experimentation yourself.

	Jeff


