Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVC1Tjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVC1Tjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVC1Tje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:39:34 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25352 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262020AbVC1TjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:39:23 -0500
Date: Mon, 28 Mar 2005 21:39:22 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Olivier Fourdan <fourdan@xfce.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Various issues after rebooting
Message-ID: <20050328193921.GW30052@alpha.home.local>
References: <1112039799.6106.16.camel@shuttle> <20050328192054.GV30052@alpha.home.local> <1112038226.6626.3.camel@shuttle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112038226.6626.3.camel@shuttle>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:30:26PM +0200, Olivier Fourdan wrote:
> Hi Willy
> 
> On Mon, 2005-03-28 at 21:20 +0200, Willy Tarreau wrote:
> > Now I have a compaq (nc8000) which does not exhibit such buggy behaviour,
> > but you can try disabling the APIC too just in case it's a similar problem
> > (at least in 32 bits, I don't know if you can disable it in 64 bits mode).
> 
> Thanks for the hint, but unfortunately, it's one of the first things I
> tried, and that makes no difference.

Sorry, at first I only noticed ACPI in your mail, but after reading it
again, I also noticed APIC. So now, you can only try not to initialize
some peripherals (IDE, network, display, etc...) by removing their drivers
from the kernel. You may end up with a kernel panic, but that does not
matter is you boot it with "panic=5" so that it automatically reboots
5 seconds after the panic. You should then finally identify the subsystem
which is responsible for your problems. Perhaps you'll even need to remove
PCI support :-(

Regards,
Willy

