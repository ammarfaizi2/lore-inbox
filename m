Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVAUGV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVAUGV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVAUGV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:21:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:7076 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262277AbVAUGVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:21:23 -0500
Date: Thu, 20 Jan 2005 22:20:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, npiggin@novell.com
Subject: Re: OOM fixes 2/5
Message-Id: <20050120222056.61b8b1c3.akpm@osdl.org>
In-Reply-To: <20050121054916.GB12647@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random>
	<20050121054916.GB12647@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  This is the forward port to 2.6 of the lowmem_reserved algorithm I
>  invented in 2.4.1*, merged in 2.4.2x already and needed to fix workloads
>  like google (especially without swap) on x86 with >1G of ram, but it's
>  needed in all sort of workloads with lots of ram on x86, it's also
>  needed on x86-64 for dma allocations. This brings 2.6 in sync with
>  latest 2.4.2x.

But this patch doesn't change anything at all in the page allocation path
apart from renaming lots of things, does it?

AFAICT all it does is to change the default values in the protection map. 
It does it via a simplification, which is nice, but I can't see how it
fixes anything.

Confused.
