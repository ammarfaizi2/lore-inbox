Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUJ3XrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUJ3XrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbUJ3XrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:47:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23983 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261415AbUJ3XrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:47:18 -0400
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
	kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Tim_T_Murphy@Dell.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099093258.5965.41.camel@at2.pipehead.org>
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
	 <20041029212029.I31627@flint.arm.linux.org.uk>
	 <1099093258.5965.41.camel@at2.pipehead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099176190.25178.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 30 Oct 2004 23:43:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-30 at 00:40, Paul Fulghum wrote:
> On Fri, 2004-10-29 at 15:20, Russell King wrote:
> > At a guess, you've enabled "low latency" setting on this port ?
> 
> Would it make sense to do something like (in tty_io.c) the following?

Not really because it can legally occur if you flip the low latency
flag while a transaction is queued. It might work if you waited for
scheduled work to complete in the flag changing.

