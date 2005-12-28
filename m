Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVL1LCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVL1LCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVL1LCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:02:01 -0500
Received: from cantor2.suse.de ([195.135.220.15]:4310 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964785AbVL1LCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:02:00 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Add memcpy32 function
References: <1135301759.4212.76.camel@serpentine.pathscale.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Dec 2005 12:01:49 +0100
In-Reply-To: <1135301759.4212.76.camel@serpentine.pathscale.com>
Message-ID: <p73fyodmqn6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan <bos@pathscale.com> writes:

> In response to the comments that followed Roland Dreier posting our
> InfiniPath driver for review last week, we've been making some cleanups
> to our driver code.

What irritates me is that the original author said this copy
would happen from user space in ipath. In that case you would need
exception handling for all memory accesses to return EFAULT,
otherwise everybody can crash the kernel.

-Andi
