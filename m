Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289504AbSAOMQV>; Tue, 15 Jan 2002 07:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289507AbSAOMQL>; Tue, 15 Jan 2002 07:16:11 -0500
Received: from ns.suse.de ([213.95.15.193]:56840 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289504AbSAOMQG>;
	Tue, 15 Jan 2002 07:16:06 -0500
To: peter@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020115025840.11509.qmail@science.horizon.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Jan 2002 13:16:04 +0100
In-Reply-To: peter@horizon.com's message of "15 Jan 2002 04:04:19 +0100"
Message-ID: <p736663kdx7.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter@horizon.com writes:

> 1) The main kernel is contiguous in physical memory and is mapped with
>    large (4 MB) pages.  This reduces pressure on the TLB.  Modules are
>    loaded in vmalloc memory, which uses small pages, and therefore
>    competes for TLB space.  This is a performance penalty, especially
>    as most current machines have undersized TLBs already.  (A 64-entry
>    TLB with 4K pages maps 256K at a time.  On-chip L2 caches are this
>    large or larger.  Thus, as a crude approximation, every L2 miss also
>    causes a TLB miss.)

-aa tries to load modules into the linear mapping when possible.
That usually works when you load the modules early when the memory 
isn't that fragmented yet.

I agree on that trying to put everything into modules isn't a good idea,
especially because of your second point.

-Andi
