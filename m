Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWALEOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWALEOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWALEOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:14:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:64489 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751377AbWALEOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:14:09 -0500
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
In-Reply-To: <200601120233.51601.ak@suse.de>
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
	 <200601120156.11529.ak@suse.de>
	 <1137029233.17705.46.camel@localhost.localdomain>
	 <200601120233.51601.ak@suse.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 20:14:02 -0800
Message-Id: <1137039242.29795.5.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 02:33 +0100, Andi Kleen wrote:

> I think it's deeply wrong to reuse names of standard functions with different
> arguments. Either pass bytes or give it some other name.

Someone (Matt Mackall?) suggested naming it __iowrite32_copy, by analogy
with the stuff in asm-generic/iomap.h, I presume.  Would that suit you?

> That sounds like a very chipset specific assumption. Is that safe
> to make?

I can fix the doc so that it says "at least 32 bits", in that case.
This should make the assumption more clear for other bus types.

	<b

