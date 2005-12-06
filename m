Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbVLFPRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbVLFPRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbVLFPRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:17:21 -0500
Received: from ns.suse.de ([195.135.220.2]:30337 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751696AbVLFPRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:17:20 -0500
To: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
References: <009201c5fa50$f3f58a10$0a016696@EW10>
From: Andi Kleen <ak@suse.de>
Date: 06 Dec 2005 12:47:07 -0700
In-Reply-To: <009201c5fa50$f3f58a10$0a016696@EW10>
Message-ID: <p73u0dmqa84.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Engraf" <engraf.david@netcom-sicherheitstechnik.de> writes:

> This patch adds a new systemcall on i386 architectures returning the jiffies
> value to the application. 
> As a kernel developer you can use jiffies but from the user space there is
> no equivalent function which counts every millisecond like the Win32
> GetTickCount.

You want a timer that never go backwards, right? 

Use clock_gettime(CLOCK_MONOTONIC). It's the POSIX way to do this.

-Andi
