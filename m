Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUA0SC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUA0SC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:02:56 -0500
Received: from ns.suse.de ([195.135.220.2]:64897 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263125AbUA0SCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:02:54 -0500
Date: Tue, 27 Jan 2004 19:02:51 +0100
From: Andi Kleen <ak@suse.de>
To: jim.houston@comcast.net
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
Message-Id: <20040127190251.4edb873d.ak@suse.de>
In-Reply-To: <1075225399.1020.239.camel@new.localdomain>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
	<20040127155619.7efec284.ak@suse.de>
	<1075225399.1020.239.camel@new.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jan 2004 12:43:20 -0500
Jim Houston <jim.houston@comcast.net> wrote:

.
> 
> It looks like we were working in lock step.  I had been meaning to
> update the patch so when I saw that Andrew had dropped it from 
> 2.6.2-rc1-mm3 it seemed like a good time.
> 
> I'll leave it to you and Andrew to decide how we should resolve our
> conflicting patches.

If yours works on ethernet please use yours. Mine didn't.


> arch/x86_64/Kconfig
> arch/x86_64/Kconfig.kgdb
> 	We used a different approach to selecting DEBUG_INFO.
> 	I was not really happy with the way select DEBUG_INFO worked.

You reverted it back? 

What I did was to change all not really kgdb specific CONFIG_KGDB uses in
the main kernel with CONFIG_DEBUG_INFO (mostly CFI support). I don't feel
strongly about it, but this way there is no reference to an unknown
config symbol in mainline. Also DEBUG_INFO including CFI makes sense I think.

Putting the kgdb options into a separate sourced file is a good idea. 
This should decrease future conflicts.

> include/asm-x86_64/kgdb_local.h
> 	This file seems to be missing from your patch.  Maybe I'm 
> 	missing something.  In my patch it is a copy of the i386
> 	version.

Probably my fault.

-Andi 
