Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268222AbUIKROZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbUIKROZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIKROY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:14:24 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:50844 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268222AbUIKRN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:13:59 -0400
Message-ID: <9e473391040911101331a584ec@mail.gmail.com>
Date: Sat, 11 Sep 2004 13:13:58 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coprocessor 3D mode is deeply pipelined
2D mode is immediate

How can you build a system that process swaps between these two modes?
The 3D pipeline has to be emptied before you can enter 2D immediate
mode.

My solution is to leave the coprocessor always running and convert
everything to use the DMA based commands.
