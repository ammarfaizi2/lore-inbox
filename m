Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUJGVVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUJGVVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUJGVTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:19:41 -0400
Received: from hera.kernel.org ([63.209.29.2]:30188 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267766AbUJGVFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:05:54 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: __init poisoning for i386, too
Date: Thu, 7 Oct 2004 21:05:45 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ck4b39$fmp$1@terminus.zytor.com>
References: <20041006221854.GA1622@elf.ucw.cz> <20041007061610.GU9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1097183145 16090 127.0.0.1 (7 Oct 2004 21:05:45 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 7 Oct 2004 21:05:45 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041007061610.GU9106@holomorphy.com>
By author:    William Lee Irwin III <wli@holomorphy.com>
In newsgroup: linux.dev.kernel
>
> On Thu, Oct 07, 2004 at 12:18:55AM +0200, Pavel Machek wrote:
> > Overwrite __init section so calls to __init functions from normal code
> > are catched, reliably. I wonder if this should be configurable... but
> > it is configurable on x86-64 so I copied it. Please apply,
> 
> Any chance we could:
> (a) set the stuff to 0x0f0b so illegal instructions come of it; jumps are
> 	most often aligned to something > 16 bits anyway
> (b) poison __initdata, memsetting to some bit pattern oopsable to dereference
> 

What's wrong with using 0xCC (breakpoint instruction)?

If you want an illegal instruction, 0xFF 0xFF is an illegal
instruction, so filling memory with 0xFF will do what you want.

	-hpa
