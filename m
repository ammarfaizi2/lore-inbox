Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbTCLU00>; Wed, 12 Mar 2003 15:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbTCLU00>; Wed, 12 Mar 2003 15:26:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47815
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261929AbTCLU0Z>; Wed, 12 Mar 2003 15:26:25 -0500
Subject: Re: bio too big device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b4nsh7$eg0$1@penguin.transmeta.com>
References: <20030312090943.GA3298@suse.de>
	 <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org>
	 <20030312101414.GB3950@suse.de> <20030312154440.GA4868@win.tue.nl>
	 <b4nsh7$eg0$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047505504.23725.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 21:45:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 17:59, Linus Torvalds wrote:
> That is definitely not true.  We definitely _have_ had drives that
> misconstrue the 256-sector case. It's been a long time, but they
> definitely exist.
> 
> The right limit for IDE is 255 sectors, and doing 256 sectors WILL fail
> on some setups.

One single possible but unclear case. I'm waiting to find out what
Win2K does.

We have had controllers that misconstrue it as the only definitive case
and that is correctly handled by the IDE code already, which splits
the DMA descriptor.

Alan

