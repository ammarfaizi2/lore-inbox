Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbTGAFwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbTGAFwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:52:42 -0400
Received: from terminus.zytor.com ([63.209.29.3]:9908 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S265976AbTGAFwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:52:38 -0400
Message-ID: <3F0124FC.1010001@zytor.com>
Date: Mon, 30 Jun 2003 23:06:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI domain stuff
References: <1057010214.1277.11.camel@albertc>	 <20030630231515.GA27813@kroah.com>	 <20030701040531.GB23597@parcelfarce.linux.theplanet.co.uk>	 <1057034041.31826.1.camel@rth.ninka.net>	 <bdr7a6$4eu$1@cesium.transmeta.com> <1057039376.32118.3.camel@rth.ninka.net>
In-Reply-To: <1057039376.32118.3.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> [ Pater, please retain the CC: list in your replies.  I scan
> linux-kernel casually at best, and I probably would have missed
> this reply of yours under normal circumstances, if you had retained
> the CC: list I would have read it via my non-lkml account and therefore
> not have missed it. ]

Unfortunately, I can't, because I never see it.  One of the very few 
disadvantages with reading LKML via a newsreader.

> On Mon, 2003-06-30 at 22:47, H. Peter Anvin wrote:
> 
>>Presumably only on architectures which use memory-mapped IO address
>>space.
> 
> On ones that don't we use the x86's existing facilities for doing
> this, ioperm() and direct I/O instructions.
> 
> These issues are platform dependant for other reasons anyways
> (endianness, barrier instructions needed, etc.)

Right.  As long as this is clear to people; I'm not sure it always is.

Perhaps a libdirectio would be useful?

> But everything the most demanding testcase in userspace needs (this
> being xfree86) needs can be done with the existing facilities.
> 
> Unlike other people, I do not see the value in having 50 ways to
> do the same thing. :-)

Agreed with that, *as long as* the implementation is sane.

	-hpa

