Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUHaWj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUHaWj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHaWil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:38:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:25025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269232AbUHaWd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:33:57 -0400
Date: Tue, 31 Aug 2004 15:36:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
Message-Id: <20040831153649.7f8a1197.akpm@osdl.org>
In-Reply-To: <20040831221348.GW3466@fs.tum.de>
References: <20040831221348.GW3466@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> An issue that we already discussed at 2.6.8-rc2-mm2 times:
> 
> 2.6.9-rc1 includes __always_inline which was formerly in  -mm.
> __always_inline doesn't make any sense:
> 
> __always_inline is _exactly_ the same as __inline__, __inline and inline .
> 
> 
> The patch below removes __always_inline again:

But what happens if we later change `inline' so that it doesn't do
the `always inline' thing?

An explicit usage of __always_inline is semantically different than
boring old `inline'.
