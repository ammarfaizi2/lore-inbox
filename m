Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVK3QWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVK3QWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVK3QWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:22:50 -0500
Received: from xenotime.net ([66.160.160.81]:30389 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751439AbVK3QWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:22:50 -0500
Date: Wed, 30 Nov 2005 08:22:48 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
In-Reply-To: <438D4905.9F023405@users.sourceforge.net>
Message-ID: <Pine.LNX.4.58.0511300821570.18317@shark.he.net>
References: <20051130042118.GA19112@kvack.org> <438D4905.9F023405@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005, Jari Ruusu wrote:

> Benjamin LaHaise wrote:
> > The following emails contain the patches to convert x86-64 to store current
> > in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).
> [snip]
> > No benchmarks that I am aware of show regressions with this change.
>
> Ben,
> Your patch breaks all out-of-tree amd64 assembler code used in kernel. r10
> register is one of those registers that does not need to be preserved across
> function calls, and reserving that register for other purpose means that all
> assembler code using r10 in kernel must be rewritten. This is deeply
> unfunny.
>
> Andi,
> Please don't apply Ben's patch. It is already bad enough having to deal with
> two incompatible calling conventions on 32 bit x86.

Just for the sake of understanding the current kernel release
process, when would something like this be acceptable/possible?
Would it require a Linux 3.0 version, or at least a 2.8?

-- 
~Randy
