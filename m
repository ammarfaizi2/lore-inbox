Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268171AbTGIKr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbTGIKr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:47:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21167
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268171AbTGIKrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:47:53 -0400
Subject: Re: [PATCH] idle using PNI monitor/mwait
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB5640201719C@fmsmsx407.fm.intel.com>
References: <3014AAAC8E0930438FD38EBF6DCEB5640201719C@fmsmsx407.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057748386.6255.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 11:59:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 22:23, Nakajima, Jun wrote:
> Hi Linus,
> 
> Attached is a patch that enables PNI (Prescott New Instructions)
> monitor/mwait in kernel idle (opcodes are now public). Basically MWAIT
> is similar to hlt, but you can avoid IPI to wake up the processor
> waiting. A write (by another processor) to the address range specified
> by MONITOR would wake up the processor waiting on MWAIT.

Is mwait dependant on cached cpu memory and the cache exclusivity logic
or directly on the processor. In other words can I use mwait in future
to wait for DMA to hit a given location ? - Im mostly thinking about
debugging uses 

