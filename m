Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUHXUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUHXUTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268266AbUHXUTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:19:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11227 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268263AbUHXUTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:19:19 -0400
Date: Tue, 24 Aug 2004 22:20:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ioport-cache-2.6.8.1.patch
Message-ID: <20040824202042.GA4712@elte.hu>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com> <20040824071928.GA7697@elte.hu> <200408241238.29702.ryan@spitfire.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408241238.29702.ryan@spitfire.gotdns.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ryan Cumming <ryan@spitfire.gotdns.org> wrote:

> On Tuesday 24 August 2004 00:19, you wrote:
> > +       if (likely(next == tss->io_bitmap_owner)) {
> 
> Probably a stupid question, but what's stopping the tss->io_bitmap_owner from being killed, and then a new
> thread_struct being kmalloc()'ed in the exact same place as the old one? I realize it's highly unlikely, I'm just
> wondering if it's possible at all.
> 
> I guess clearing tss->io_bitmap_owner whenever we kfree() the bitmap owner's thread_struct would plug that up.

the patch flushes the ->io_bitmap_owner info on thread exit.

	Ingo
