Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVHIHJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVHIHJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVHIHJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:09:59 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:2432 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932415AbVHIHJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:09:58 -0400
Date: Tue, 9 Aug 2005 09:09:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
cc: arnd@arndb.de, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: Re: [HELP] How to get address of module
In-Reply-To: <20050809.094349.112599262.kaminaga@sm.sony.co.jp>
Message-ID: <Pine.LNX.4.61.0508090907580.1805@yvahk01.tjqt.qr>
References: <20050808214822.531ee849.sfr@canb.auug.org.au>
 <20050808.210645.78734846.kaminaga@sm.sony.co.jp> <200508081530.54180.arnd@arndb.de>
 <20050809.094349.112599262.kaminaga@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>What I wanted is: given the segfault address, I would like to 
>
>1) get which module it is in
>2) in that module, within which function it segfaulted
>
>module_address_lookup would do!

If a kernel oopses or similar, it already prints where it faulted:

  EIP is at schedule_timeout+0x1234/abcde

If you have the EIP, you can look at /proc/modules to find the module, and 
then use "nm" to find the function. Note that inlining makes "nm" and 
objdumpers less effective.



Jan Engelhardt
-- 
