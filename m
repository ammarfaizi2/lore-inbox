Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTESXJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTESXJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:09:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47799
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263275AbTESXJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:09:44 -0400
Subject: Re: [PATCH] Exception trace for i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1053377808.588720@palladium.transmeta.com>
References: <20030519192814.GA975@averell>
	 <1053377808.588720@palladium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053383062.29226.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 23:24:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-19 at 21:56, Linus Torvalds wrote:
> >proved to be very useful to trace otherwise hidden faults, e.g.
> >on a normal kernel there is no way to see a segfault in a process
> >that runs in a write protected directory, even when core dumps
> >are enabled. Also it's useful as an early warning that something
> >is wrong with your system.

You can change the segfault path for core dumps via /proc 

> I don't think it's ever really valid to expose it as a global option, as
> some programs use page faults (even the signalling kind) to do their own
> memory management, and making it a global option just makes it hard to
> work with such programs.

The classic being the texas objectstore which I suspect would not be
happy if printk logged each fault 8)

