Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266549AbUGPTSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUGPTSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUGPTSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 15:18:52 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:18862 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266549AbUGPTSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 15:18:50 -0400
Date: Fri, 16 Jul 2004 21:18:50 +0200
From: bert hubert <ahu@ds9a.nl>
To: Brian McEntire <brianm@fsg1.nws.noaa.gov>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: Suggestions with hard lockup on 4 systems, have oops report
Message-ID: <20040716191850.GA5997@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Brian McEntire <brianm@fsg1.nws.noaa.gov>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
References: <Pine.LNX.4.44.0407161025030.20914-200000@fsg1.nws.noaa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407161025030.20914-200000@fsg1.nws.noaa.gov>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 11:01:39AM -0400, Brian McEntire wrote:
> Thank you for taking time from your busy days to read this. You all
> (kernel maintainers) rock!  :)

You are running one of the kernels not a lot of people outside of red hat
know the details about. 

> The systems are:
>   Dual Xeon 2.4GHz processors
>   2 GB RAM
>   2 GB swap
>   Ethernet controller: PCI device 14e4:16a7 (BROADCOM Corporation) (rev 2)
>   Dual channel SCSI storage controller: PCI device 1000:0030 (Symbios
>     Logic Inc. (formerly NCR)) (rev 7)

This kind of hardware just asks for 2.6. Furthermore, you'll find that
current kernel hackers will be in a far better position to help you.

>  bcm5700-7.1.22-1

In a recent kernel, you will probably be able to use the tg3 driver instead
of this vendor supplied one, which is generally considered to be inferior or
at least uglier than the in kernel one.


> Code;  f89b669f <[bcm5700]LM_ServiceInterrupts+cf/230>
> 00000000 <_EIP>:
> Code;  f89b669f <[bcm5700]LM_ServiceInterrupts+cf/230>   <=====
>    0:   c7 03 00 00 00 00         movl   $0x0,(%ebx)   <=====

I'm no expert, but this strongly looks like problems in the broadcom driver.

> 133 warnings and 7 errors issued.  Results may not be reliable.

2.6 also has a built-in ksymoops, which gives far more reliable results.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
