Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUEWLKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUEWLKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 07:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEWLKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 07:10:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61135 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262503AbUEWLJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 07:09:42 -0400
Date: Sun, 23 May 2004 07:08:36 -0400
From: Alan Cox <alan@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, alan@redhat.com,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
Message-ID: <20040523110836.GE25746@devserv.devel.redhat.com>
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523082912.GA16071@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 10:29:12AM +0200, Willy Tarreau wrote:
>     being emulated. I think it's already the case. He also said that I
>     didn't take care of the segment selectors (such as SS) which some
>     programs use perfectly legally (eg Wine). I don't know how to do
>     that.

You have to parse all the valid header bytes (the opcode prefixes) that
change segment, cause repeats and change sizes. DOSemu has a worked example
of this particular set of horrors.

>   - why not include the CMOV emulation while we're at it ? There are so
>     many people using VIA EDEN chips who think it's i686 compatible that
>     they may get hit too. IIRC, the chip only executes CMOV on registers,
>     but very slowly (a few tens of cycles), while register to memory
>     accesses generate a trap.

gcc generates a lot of cmov on i686 so many that people I've talked with
on the compiler side also feel cmov emulation isnt useful. Newer Eden btw
has cmov.

> Other than that, I'm happy that someone found it useful, and happy too that
> someone did the 2.6 port :-)

Is there a reason btw it can't be done with LD_PRELOAD ?

