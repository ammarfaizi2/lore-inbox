Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWHWVRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWHWVRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWHWVRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:17:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:20965 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965207AbWHWVRb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:17:31 -0400
To: =?iso-8859-1?q?Bj=F6rn_Engelhardt?= <bjoern2@xqueue.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.17.8 on Quad AMD Opteron 852 with 16x 4GB Modules (64GB RAM)
References: <44EC4EE2.6060701@xqueue.de>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 23:17:25 +0200
In-Reply-To: <44EC4EE2.6060701@xqueue.de>
Message-ID: <p73d5ar5eze.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Engelhardt <bjoern2@xqueue.de> writes:

> we upgraded a Server from 32 GB RAM to 64 GB. Now we try to get a
> Linux (FC5) with kernel 2.6.17.8 on a Quad Opteron (852; 64bit)-system
> with 16x 4GB modules to run.
> With 32 GB (8x 4GB modules) the system starts without any problems,
> but above I get kernelpanics.

It 99.9+% likely a hardware or BIOS or power supply/VRM/cooling
problem of some sort. So many DIMMs are quite stress full
to the system and can expose issues which were hidden before.
Or you might run into some other BIOS/hardware issue.

You can post the exact text of the panics from a serial console
if you want, but most likely you will get the same answer even then.

I would start talking to your hardware vendor.

> The output then gives me several memoryaddresses bevore the panic
> appears. The board (a Tyan K8QW,model S4881) should support up to 64GB
> Ram. A Memorytest under Linux recognizes the 64GB and continues
> without an error.
> I tried several BIOS-Settings.
> Does the kernel support the new 4GB-Modules by 64GB Ram?

The kernel doesn't know anything about DIMMs, it just gets a memory
map from the BIOS.

-Andi
