Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUBDOaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 09:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUBDOaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 09:30:22 -0500
Received: from intra.cyclades.com ([64.186.161.6]:39316 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262040AbUBDOaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 09:30:21 -0500
Date: Wed, 4 Feb 2004 12:30:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Robert Love <rml@ximian.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4's sys_readahead is borked
In-Reply-To: <1075853962.8022.3.camel@localhost>
Message-ID: <Pine.LNX.4.58L.0402041224050.1700@logos.cnet>
References: <1075853962.8022.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Feb 2004, Robert Love wrote:

> In 2.4, sys_readahead() performs readahead against a maximum of half the
> number of inactive pages.  This is dumb, as it ignores the number of
> free pages completely.  Worse, in certain situations, such as boot, the
> inactive list can be quite small and the free list quite large, but
> readahead(2) won't do anything.
>
> The right thing to do is limit sys_readahead() to a maximum of half of
> the sum of the number of free pages and inactive pages, which is what
> 2.6 does.

Hi Robert,

This looks okay, applied.

Question: Do you know any user of sys_readahead() ?

