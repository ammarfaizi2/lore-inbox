Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280254AbRKEGW6>; Mon, 5 Nov 2001 01:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280255AbRKEGWs>; Mon, 5 Nov 2001 01:22:48 -0500
Received: from ns.suse.de ([213.95.15.193]:30217 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280254AbRKEGWg>;
	Mon, 5 Nov 2001 01:22:36 -0500
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification
In-Reply-To: <E160aCK-0001Fs-00@localhost.suse.lists.linux.kernel> <200111050552.AAA06451@ccure.karaya.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Nov 2001 07:22:28 +0100
In-Reply-To: Jeff Dike's message of "5 Nov 2001 05:44:11 +0100"
Message-ID: <p73vggpybx7.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Jeff Dike <jdike@karaya.com> writes:

> Ummm, how about O_DIRECT instead of O_SYNC (or maybe as well, my googling
> hasn't been clear on whether O_DIRECT bypasses the cache on writes as well)?

It does, but it has been deimplemented in the Linus tree and never put into
the -ac tree. You would need -aa for working O_DIRECT or use a raw device.

Also they both have some restrictions on buffer alignment, but these would be 
already fulfilled if UML internally writes through the page cache (which 
it does of course)

-Andi
