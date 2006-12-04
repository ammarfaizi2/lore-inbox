Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937034AbWLDPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937034AbWLDPqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937038AbWLDPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:46:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60914 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937034AbWLDPqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:46:54 -0500
Date: Mon, 4 Dec 2006 07:46:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow 32-bit and 64-bit hashes
In-Reply-To: <20061204104749.GC3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612040746170.3476@woody.osdl.org>
References: <20061204104749.GC3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2006, Matthew Wilcox wrote:
>
> The sym2 driver would like to hash a u32 value, and it could just
> call hash_long() and rely on integer promotion on 64-bit machines, but
> that seems a little wasteful.

Hmm. It would appear that the <linux/hash.h> file now needs 
<linux/types.h>, no?

I do think it's a good change otherwise.

		Linus
