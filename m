Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbUCZSBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUCZSBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:01:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35242
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264099AbUCZSBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:01:42 -0500
Date: Fri, 26 Mar 2004 19:02:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040326180235.GD9604@dualathlon.random>
References: <20040325214529.GJ20019@dualathlon.random> <Pine.LNX.4.44.0403261107100.16019-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403261107100.16019-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 11:57:23AM +0000, Hugh Dickins wrote:
> Andrea's 2.6.5-rc2-aa4 (anon_vma): based on Martin's, but very
> likely safe since it does not use find_vma at all in swapout, and
> unuse_process downs mmap_sem as Martin's used to before.

Hugh, thanks for the review! I also don't see locking bugs in this area
in my tree and I like not to take the page_table_lock during vma
manipulations since I don't seem to need it.
