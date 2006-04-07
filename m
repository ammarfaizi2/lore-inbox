Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWDGRBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWDGRBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWDGRBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:01:20 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:62913 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964815AbWDGRBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:01:19 -0400
Date: Fri, 7 Apr 2006 12:02:18 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/17] uml: fix 2 harmless cast warnings for 64-bit
Message-ID: <20060407160218.GA4962@ccure.user-mode-linux.org>
References: <20060407142709.19201.99196.stgit@zion.home.lan> <20060407143054.19201.89200.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407143054.19201.89200.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 04:30:54PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Fix two harmless warnings in 64-bit compilation (the 2nd doesn't trigger for now
> because of a missing __attribute((format)) for cow_printf, but next patches fix
> that).

I don't object to this bit, but it doesn't seem to match the comment.  Was
there another cast that you meant to have here, but missed?

> -		n = min((size_t)len, ARRAY_SIZE(console_buf) - console_index);
> +		n = min((size_t) len, ARRAY_SIZE(console_buf) - console_index);

				Jeff
