Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTDFWEY (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbTDFWEX (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:04:23 -0400
Received: from mail-1.tiscali.it ([195.130.225.147]:24356 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S263140AbTDFWEU (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 18:04:20 -0400
Date: Mon, 7 Apr 2003 00:15:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Rik van Riel <riel@surriel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Bill Irwin <wli@holomorphy.com>
Subject: Re: subobj-rmap
Message-ID: <20030406221547.GP1326@dualathlon.random>
References: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com> <1600000.1049666582@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600000.1049666582@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 03:03:03PM -0700, Martin J. Bligh wrote:
> We can always leave the sys_remap_file_pages stuff using pte_chains,

not sure why you want still to have the vm to know about the
mmap(VM_NONLINEAR) hack at all.

that's a vm bypass. I can bet the people who wants to use it for running
faster on the the 32bit archs will definitely prefer zero overhead and
full hardware speed with only the pagetable and tlb flushing trash, and
zero additional kernel internal overhead. that's just a vm bypass that
could otherwise sit in kernel module, not a real kernel API.

Andrea
