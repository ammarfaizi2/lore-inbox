Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbUADUyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 15:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUADUyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 15:54:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:3849 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263638AbUADUyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 15:54:22 -0500
Date: Sun, 4 Jan 2004 21:54:11 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Willy Tarreau <willy@w.ods.org>, Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040104205411.GA219@pcw.home.local>
References: <1073075108.9851.16.camel@localhost> <20040103191901.GC3728@alpha.home.local> <16376.31727.114173.311369@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16376.31727.114173.311369@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Jan 05, 2004 at 07:47:43AM +1100, Peter Chubb wrote:

> >> So it is like 30 times slower on 2.6. when running for the first
> >> time...  this also happens if I do e.g. find ./ and watch the
> >> output pass by...
> >> 
> >> This is without preemption on powerpc...
> >> 
> >> Anyone else with that problem - ideas of the cause ?
> 
> I see a very similar problem ... seems like a process doing disc I.O
> isn't being woken up fast enough after the I/O completes.
> 
> For some processes, allowing interrupts back on (hdparm -u1) helps;
> for others, switching to the deadline elevator helps; neither are
> complete solutions.

This is not I/O related since the problem happens even with simple
programs such as dmesg and seq.

Cheers,
willy

