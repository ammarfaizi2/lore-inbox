Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbSLSKIs>; Thu, 19 Dec 2002 05:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbSLSKIs>; Thu, 19 Dec 2002 05:08:48 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:20740 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267609AbSLSKIr>; Thu, 19 Dec 2002 05:08:47 -0500
Message-Id: <200212191010.gBJAAJs28289@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 15000+ processes -- poor performance ?!
Date: Thu, 19 Dec 2002 12:59:28 -0200
X-Mailer: KMail [version 1.3.2]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3E0116D6.35CA202A@inw.de>
In-Reply-To: <3E0116D6.35CA202A@inw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 December 2002 22:46, Till Immanuel Patzschke wrote:
> Dear List(s),
>
> as part of my project I need to run a very high number of
> processes/threads on a linux machine.  Right now I have a Dual-PIII
> 1.4G w/ 8GB RAM -- I am running 4000 processes w/ 2-3 threads each
> totaling in a process count of 15000+ processes (since Linux doesn't
> really distinguish between threads and processes...).

BTW, can you say _what_ are you trying to do?

> Once I pass the 10000 (+/-) pocesses load increases drastically (on
> startup, although it returns to normal), however the system time (on
> one processor) reaches for 54% (12061 procs) while the only non
> sleeping process is top -- the system is basically doing nothing
> (except scheduling the "nothing" which consumes significant system
> time).
> Is there anything I can do to reduce that system load/time?  (I
> haven't been able to exactly define the "line" but it definitly gets
> worse the more processes need to be handled.)
> Does any of the patchsets address this particular problem?
> BTW: The processes are all alike...

You need to collect memory info (especially lowmem and highmem situation)
and maybe profile your kernel to find out where does it spend that time
doing "nothing".

BTW, your .config?
--
vda
