Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUCVEpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUCVEpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:45:21 -0500
Received: from ns.suse.de ([195.135.220.2]:44731 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261704AbUCVEpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:45:16 -0500
Date: Mon, 22 Mar 2004 05:45:12 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
Message-Id: <20040322054512.0333dad8.ak@suse.de>
In-Reply-To: <20040322043454.GL3649@dualathlon.random>
References: <20040322051318.597ad1f9.ak@suse.de>
	<20040322043454.GL3649@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004 05:34:54 +0100
Andrea Arcangeli <andrea@suse.de> wrote:


> 32bit archs needs to get O_LARGEFILE in return from getfl (if they set
> it [it's not set implicitly in 32bit archs] they will be able to handle
> it transparently in glibc too, and I believe they really want it). 64bit
> archs not, hence the fix.

If 32bit archs need it then 64bit archs need it too (think 32bit emulated processes
on 64bit jernels)  But I think in practice it doesn't matter, so I would prefer to be 
consistent between 32bit and 64bit.

I don't feel very strongly about this however ...

-Andi
