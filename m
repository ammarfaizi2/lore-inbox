Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUFCUTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUFCUTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUFCUTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:19:33 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10944 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264218AbUFCUTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:19:30 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: Stock IA64 kernel on SGI Altix 350
Date: Thu, 3 Jun 2004 13:19:06 -0700
User-Agent: KMail/1.6.2
Cc: Nathan Straz <nstraz@sgi.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
References: <20040603170147.GK10708@fi.muni.cz> <200406031030.36181.jbarnes@engr.sgi.com> <20040603200905.GA27701@fi.muni.cz>
In-Reply-To: <20040603200905.GA27701@fi.muni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031319.06466.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 3, 2004 1:09 pm, Jan Kasprzak wrote:
> 	Wow, mail to lkml is way faster than asking local SGI support :-).
> Thank you all for fast reply and sorry for posting to the wrong list.

Cool, but keep in mind that this is totally unsupported.  If this kernel 
breaks, you get to keep both pieces (though I'll try to help glue it back 
together!) :)

> 	Thanks, I did not know about sn2_defconfig nor compressed
> (I was trying to boot gzip-9'ed vmlinux, which was probably the reason
> of why I failed). Is make sn2_defconfig and make compressed documented
> anywhere in the kernel sources? I think short
> Documentation/ia64/README.Altix or README.sn2 would be helpful.

I think 'make help' documents most of it.

> 	However - it still does not work, altough I got at least some
> console messages. I have tried both stock 2.6.6 and 2.6.7-rc2-mm2
> (make sn2_defconfig, make -j compressed).
>
> Uncompressing Linux... done
> Memory: 11803200k/11929104k available (7422k code, 137904k reserved, 4016k
> data, 336k init) McKinley Errata 9 workaround not needed; disabling it
> Calibrating delay loop... 2077.40 BogoMIPS
> Dentry cache hash table entries: 2097152 (order: 10, 16777216 bytes)
> Inode-cache hash table entries: 1048576 (order: 9, 8388608 bytes)
> Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
> Boot processor id 0x0/0x0
> task migration cache decay timeout: 10 msecs.
> Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
> Boot processor id 0x0/0x0
> task migration cache decay timeout: 10 msecs.
> CPU 1: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
> Calibrating delay loop... 16.44 BogoMIPS
>
> ... both kernel versions (2.6.6 and 2.6.7-rc2-mm2) hang there. Also note
> the strange bogomips value for CPU 1. The system has three bricks
> (6 CPUs, 1400MHz/3MB cache). Firmware is pretty recent (the newest
> we could find at www.sgi.com):
>
> 002c06#0a: SGI SAL Version 3.25 rel040225 IP41 built 12:01:43 PM Feb 25,
> 2004

These messages are consistent with having a PROM that's too old; you need at 
least 3.32.  You'll have to dig around the support site some more or talk to 
your support person for that though.  Booting with 'nohalt' should work 
around this particular issue though.

Jesse

