Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTJXNvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 09:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTJXNvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 09:51:15 -0400
Received: from ns.suse.de ([195.135.220.2]:16312 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262192AbTJXNvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 09:51:14 -0400
Date: Fri, 24 Oct 2003 15:51:12 +0200
From: Andi Kleen <ak@suse.de>
To: Jim Houston <jim.houston@ccur.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Is there a kgdb for Opteron for linux-2.6?
Message-ID: <20031024135112.GE2286@wotan.suse.de>
References: <1066678923.1007.164.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066678923.1007.164.camel@new.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 03:42:03PM -0400, Jim Houston wrote:
> Hi Andi,
> 
> I found your kgdb for x86_64 for linux-2.4.20 and I'm wondering if 
> there is a version for the 2.6 tree?
> 
> If it doesn't exist, I'm thinking of merging your changes with the
> current i386 kgdb from Andrew Morton's tree.

There is no 2.6 version of kgdb currently. The 2.4 version also has some
problems that makes it better to not use it at all.

My plan was to do a fresh port from the code in -mm* and get rid of 
many of the ugly hacks in 2.4. Doing this properly requires adding
dwarf2 annotation to entry.S and other assembly files. This would
allow to get rid of the "interrupt threads" hack in 2.4 because gdb
could directly backtrace through exception/interrupts.

-Andi

