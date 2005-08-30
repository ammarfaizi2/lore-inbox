Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVH3Bzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVH3Bzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVH3Bzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:55:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750885AbVH3Bzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:55:50 -0400
Date: Mon, 29 Aug 2005 18:54:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: sonnyrao@us.ibm.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
Message-Id: <20050829185406.199e3aed.akpm@osdl.org>
In-Reply-To: <4313AEC9.3050406@yahoo.com.au>
References: <1125159996.5159.8.camel@mulgrave>
	<20050827105355.360bd26a.akpm@osdl.org>
	<1125276312.5048.22.camel@mulgrave>
	<20050828175233.61cada23.akpm@osdl.org>
	<1125278389.5048.30.camel@mulgrave>
	<20050828183531.0b4d6f2d.akpm@osdl.org>
	<1125285994.5048.40.camel@mulgrave>
	<4312830C.8000308@yahoo.com.au>
	<20050829164144.GC9508@localhost.localdomain>
	<4313AEC9.3050406@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> But of course gang lookup is only useful if a single read() call
>  asks for more than 1 page - is that a performance critical path?

readahead should do gang lookups (or, preferably, find-next, when it's
implemented).  But nobody got around to it.
