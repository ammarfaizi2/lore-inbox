Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268256AbTCFTvM>; Thu, 6 Mar 2003 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268317AbTCFTvM>; Thu, 6 Mar 2003 14:51:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52135
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268256AbTCFTvL>; Thu, 6 Mar 2003 14:51:11 -0500
Subject: Re: [PATCH] move SWAP option in menu
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gabriel Paubert <paubert@iram.es>
Cc: Tom Rini <trini@kernel.crashing.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       randy.dunlap@verizon.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030306193344.GA29166@iram.es>
References: <3E657EBD.59E167D6@verizon.net> <20030305181748.GA11729@iram.es>
	 <20030305131444.1b9b0cf2.rddunlap@osdl.org>
	 <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net>
	 <20030306193344.GA29166@iram.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046984808.18158.115.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 21:06:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 19:33, Gabriel Paubert wrote:
> I'd be very surprised if it were possible to have swap on a MMU-less 
> machine (no virtual memory, page faults, etc.). Except for this nitpick, 
> the patch looks fine, but my knowledge of MM is close to zero (and 
> also of the new config language, but I'll have to learn it soon).

You can, and people have had swapping long before virtual memory. Most
ucLinux platforms can't swap because they can't dynamically relocate code.
Linux 8086 can swap because it can use CS/DS updates to relocate code/data.

The way it worked on older systems is that you never run a program which
isnt entirely in memory. With that constraint you know it won't suddenely
want data you don't have

