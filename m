Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVBJRDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVBJRDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVBJRCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:02:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262163AbVBJRCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:02:32 -0500
Date: Thu, 10 Feb 2005 12:02:17 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, <davem@davemloft.net>, <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1108034244.14335.59.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502101159450.9016-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005, Fruhwirth Clemens wrote:

> Hm, alright. So I'm going take the internal of kmap_atomic into
> scatterwalk.c. to test if the page is in highmem, with PageHighMem. If
> it is, I'm going to kmap_atomic and mark the fixmap as used. If it's
> not, I do the "mapping" on my own with page_address.

No, you do not need to do any of this.

Per previous email, all you need is the existing two kmaps, pass the tweak 
in as a linear buffer.

> Btw folks: why are there UpperCamelCase functions in linux/page-flags.h
> and you're whining about my camelcase style in gfmulseq.c? My file isn't
> even intended to be included by other files, unlike this include file.

I don't know why the code is like that, but it is not an excuse to put 
more like it into the kernel.


- James
-- 
James Morris
<jmorris@redhat.com>


