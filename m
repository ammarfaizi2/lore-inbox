Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268391AbTCFV0g>; Thu, 6 Mar 2003 16:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTCFV0f>; Thu, 6 Mar 2003 16:26:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19880
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268391AbTCFV0f>; Thu, 6 Mar 2003 16:26:35 -0500
Subject: RE: HT and idle = poll
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB56401338853@fmsmsx407.fm.intel.com>
References: <3014AAAC8E0930438FD38EBF6DCEB56401338853@fmsmsx407.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046990549.17715.127.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 22:42:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 21:15, Nakajima, Jun wrote:
> Linus,
> 
> That's correct. Basically mwait is similar to hlt, but you can avoid IPI to wake up the processor waiting. A write to the address specified by monitor wakes up the processor, unlike hlt.
> 
> So our plan is to use monitor/mwait in the idle loop, for example, in the kernel to lower the latency.

Thats nice. It means you've got the basis of the instructions (although not quite the same
exact functionality) as Brian Grayson proposed four years ago with Armadillo.

