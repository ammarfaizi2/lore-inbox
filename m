Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272324AbTHILCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 07:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272327AbTHILCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 07:02:46 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:38028 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272324AbTHILCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 07:02:45 -0400
Subject: Re: Physically contiguous (DMA) memory allocation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anthony Truong <Anthony.Truong@mascorp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1060328695.9074.95.camel@huykhoi>
References: <1060328695.9074.95.camel@huykhoi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060426740.4937.85.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Aug 2003 11:59:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-08 at 08:44, Anthony Truong wrote:
> Is there a quick solution to this problem, like increasing the size of
> the physically contiguous page pool (like in Windows NT and some other
> OS'es :-( )? (Is it a good idea to make this one of the future
> enhancements to Linux?)  Or should I write a driver loaded at boot time
> grabbing the required memory pages and allocating them to my loadable
> driver when requested?
> Your suggestion is very much appreciated.

Without source code its hard to tell what you are doing but all
allocations made with the pci_* API in Linux are contiguous. If your
hardware requires a single contiguous 30Mb chunk then you have a problem
and will need to allocate at boot time.

