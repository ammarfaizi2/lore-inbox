Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUAUAMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUAUAMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:12:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:56533 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263832AbUAUAMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:12:12 -0500
Subject: Re: swsusp does not stop DMA properly during resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040120235347.GE1234@elf.ucw.cz>
References: <20040120224653.GA19159@elf.ucw.cz>
	 <20040120150629.6949eda7.akpm@osdl.org> <1074642037.739.49.camel@gaston>
	 <20040120235347.GE1234@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074643756.793.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jan 2004 11:09:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmmm... yes, I'll need to fix that one. [Is there console semaphore in
> 2.6.1, or do I need to wait for 2.6.2 before I can do something with
> this?]

{acquire,release}_console_sem() is in. I just added the warnings.

I also added proper take/release of it in the kernel/power/console.c
code, so you shouldn't have to touch that part

Ben.


