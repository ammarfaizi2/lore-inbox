Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbUKLTdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbUKLTdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKLTdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:33:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:7903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262211AbUKLTcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:32:22 -0500
Date: Fri, 12 Nov 2004 11:32:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Guido Guenther <agx@sigxcpu.org>
cc: adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
In-Reply-To: <20041112191852.GA4536@bogon.ms20.nix>
Message-ID: <Pine.LNX.4.58.0411121130550.2301@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
 <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
 <20041112125125.GA3613@bogon.ms20.nix> <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
 <20041112191852.GA4536@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Nov 2004, Guido Guenther wrote:
>
> O.k., it was the __raw_{write,read}b which broke things, not the
> "alignment". This one works:

All right, that's as expected. However, it does seem to point out that the 
riva driver depends on _different_ memory ordering guarantees for the 
8-bit accesses as opposed to the other ones. Whee. Can you say "UGGLEE"?

Anyway, patch applied. Thanks,

		Linus
