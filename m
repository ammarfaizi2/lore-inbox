Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSLCQui>; Tue, 3 Dec 2002 11:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSLCQui>; Tue, 3 Dec 2002 11:50:38 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:10932 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S261868AbSLCQuh>;
	Tue, 3 Dec 2002 11:50:37 -0500
Message-ID: <3DECE29D.10BBEBA6@hp.com>
Date: Tue, 03 Dec 2002 09:58:05 -0700
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Extract configuration from kernel
References: <E18Ixu4-0007zZ-00@lyra.fc.hp.com> <asican$58p$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> 
> | 2. Include configuration in kernel image file but not in the running
> | kernel. This adds to the kernel image file size but not the footprint of
> | running kernel. Configuration can be extracted from kernel image file
> | using scripts/extract-ikconfig. This script is in principle the same as
> | what Randy had written originally. I have made it little more robust and
> | structured it to accomodate more than just x86 architecture.
>
> I would suggest that making (2) available as a module would be useful,
> assuming that at some point 2.5 will have working module capability
> again. With a bit of tweaking you could make the kernel loader pull it
> in if a process accessed the file, I guess.

It is trivial to make (2) available as a module but it has been debated
that having configuration information available as module does not make
the job of keeping a reliable source of kernel configuration any easier
than just keeping a copy of config file in, say, /lib/modules directory.
If you can ensure you always have the right module file available for
the running kernel, you can also ensure you always have the right config
file available for the kernel. 

--
Khalid 

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini
