Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWALEUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWALEUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWALEUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:20:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:53941 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965020AbWALEUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:20:35 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
Date: Thu, 12 Jan 2006 05:19:12 +0100
User-Agent: KMail/1.8
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com> <200601120233.51601.ak@suse.de> <1137039242.29795.5.camel@camp4.serpentine.com>
In-Reply-To: <1137039242.29795.5.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120519.12960.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 05:14, Bryan O'Sullivan wrote:

> > That sounds like a very chipset specific assumption. Is that safe
> > to make?
>
> I can fix the doc so that it says "at least 32 bits", in that case.
> This should make the assumption more clear for other bus types.

Well it seems quite wrong - an iowrite32 shouldn't write more than 32bits
at a time.

My feeling is more and more that this thing is so specialized for your setup
and so narrow purpose that you're best off dropping this whole patchkit and 
just put the assembly into your driver. At least normal kernels wouldn't be 
bloated with such unlikely to be useful for anything else functions then.

-Andi
