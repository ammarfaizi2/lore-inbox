Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUGIFGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUGIFGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 01:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGIFGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 01:06:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:31415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264261AbUGIFGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 01:06:30 -0400
Date: Thu, 8 Jul 2004 22:05:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christopher Swingley <cswingle@iarc.uaf.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ issues, (nobody cared, disabled), not USB
Message-Id: <20040708220522.73839ea3.akpm@osdl.org>
In-Reply-To: <20040708155356.GG22065@iarc.uaf.edu>
References: <20040708155356.GG22065@iarc.uaf.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
>
> Greetings!
> 
> For the past few iterations of 2.6 (including the vanilla 2.6.7 I'm 
> running now) I've had this problem:
> 
>  03:27:26 kernel: irq 7: nobody cared!
> ...
> I've tried booting without ACPI, and I've tried an eepro100 card instead 
> of the 8139too that's causing the error above.  I believe I've tried 
> different PCI slots for the second ethernet card too, but I may be 
> mistaken about that.  No matter what I've tried, under 2.6, the second 
> ethernet card gets disabled at some point between a few hours and a few 
> days after the system boots.

hmm, so the eepro100 failed in the same way as the rtl8139?

That would tend to point at the PIC losing its brains.

It would be useful if you could go back to 2.6.5 for a while, so we can
mostly-eliminate a hardware glitch.
