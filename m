Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264906AbSJOV33>; Tue, 15 Oct 2002 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbSJOV33>; Tue, 15 Oct 2002 17:29:29 -0400
Received: from zero.aec.at ([193.170.194.10]:40210 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S264906AbSJOV32>;
	Tue, 15 Oct 2002 17:29:28 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-aa1: unresolved symbol in xfs.o
References: <20021015172558.A3154@pc9391.uni-regensburg.de>
	<20021015161908.GC2546@dualathlon.random>
From: Andi Kleen <ak@muc.de>
Date: 15 Oct 2002 23:35:21 +0200
In-Reply-To: <20021015161908.GC2546@dualathlon.random>
Message-ID: <m37kgjl71i.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> I logged it so it will be fixed. You can link it into the kernel in the
> meantime (select Y instead of M). For some reason bleeding edge gcc from
> CVS generates a flood of symbol errors when I run depmod before
> rebooting, so I don't easily notice these missing exports anymore (I
> should run depmod post reboot to notice them). thanks,

Upgrade your modutils.

Newer binutils changes the format of System.map and __ksym* symbols
have a 'R' now instead of a '?' in the type field. This breaks old modutils 
which have the '?' hardcoded.

-Andi
