Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbULZXZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbULZXZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 18:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbULZXZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 18:25:09 -0500
Received: from albireo.enyo.de ([212.9.189.169]:29325 "EHLO albireo.enyo.de")
	by vger.kernel.org with ESMTP id S261326AbULZXZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 18:25:02 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: 7eggert@gmx.de, Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [3/4]: Add support for ZEROED and NOT_ZEROED free maps
References: <fa.n0l29ap.1nqg39@ifi.uio.no> <fa.n04s9ar.17sg3f@ifi.uio.no>
	<E1ChwhG-00011c-00@be1.7eggert.dyndns.org>
	<87wtv464ty.fsf@deneb.enyo.de>
	<Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org>
Date: Mon, 27 Dec 2004 00:24:56 +0100
In-Reply-To: <Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org> (Linus
	Torvalds's message of "Sun, 26 Dec 2004 15:12:45 -0800 (PST)")
Message-ID: <87llbk63sn.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> Anyway, at this point I think the most interesting question is whether it 
> actually improves any macro-benchmark behaviour, rather than just a page 
> fault latency tester microbenchmark..

By the way, some crazy idea that occurred to me: What about
incrementally scrubbing a page which has been assigned previously to
this CPU, while spinning inside spinlocks (or busy-waiting somewhere
else)?
