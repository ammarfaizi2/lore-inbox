Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263651AbUDOVOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUDOVOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:14:00 -0400
Received: from mail.enyo.de ([212.9.189.167]:52999 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S263651AbUDOVNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:13:43 -0400
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overlay ramdisk on filesystem?
References: <407EF9C4.4070207@techsource.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Thu, 15 Apr 2004 23:13:40 +0200
In-Reply-To: <407EF9C4.4070207@techsource.com> (Timothy Miller's message of
 "Thu, 15 Apr 2004 17:08:20 -0400")
Message-ID: <87hdvl7xmj.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

> I have a feeling that this may be a bit too off-topic, but I'm doing
> some Linux and hardware performance tests, and some of the tests will
> put the hardware into an unstable state which could get memory errors
> which could cause filesystem corruption.

In the presence of memory errors, all bets are off anyway.

> I would like to know how I could overlay a RAM disk over a read-only
> filesystem so that all new files and modified files end up in the RAM
> disk, but old files are read from the disk.  This way, when I reboot,
> the disk reverts back.

You might have to tweak the underlying file system, too.  IIRC, ext2
avoids to reallocate freshly deallocated blocks, to prevent
fragmentation.  This will waste a lot of RAM on the long run.

-- 
Current mail filters: many dial-up/DSL/cable modem hosts, and the
following domains: bigpond.com, postino.it, tiscali.co.uk, tiscali.cz,
tiscali.it, voila.fr.
