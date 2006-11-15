Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030688AbWKOQnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688AbWKOQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbWKOQnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:43:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:22977 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030688AbWKOQnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:43:15 -0500
To: "Jan Beulich" <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: fix MTRR code
References: <455B3D8B.76E4.0078.0@novell.com>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2006 17:43:12 +0100
In-Reply-To: <455B3D8B.76E4.0078.0@novell.com>
Message-ID: <p73ac2sd5jz.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> writes:

> While after a previous submission (about one and a half year ago) I got
> told that the MTRR code is to be replaced by PAT use, this hasn't

Work is going on, patches exist, but do need more work and more
testing. I hope to put a subset (without new user interface) into -mm* for 
testing soon.

> happened. Hence I'd like to ask to reconsider this patch until PAT
> handling code shows up.

Added thanks.

Next time please only do one change / patch please.

I also got one reject in generic.c for

-       if (base + size < 0x100) {
+       if (base < 0x100) {

but I hope that's ok

-Andi

