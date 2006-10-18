Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWJRSi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWJRSi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWJRSi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:38:29 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:29847 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161264AbWJRSi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:38:27 -0400
Date: Wed, 18 Oct 2006 14:37:07 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 04/10] uml: make execvp safe for our usage
Message-ID: <20061018183707.GB6566@ccure.user-mode-linux.org>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan> <20061017212711.26445.79770.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017212711.26445.79770.stgit@americanbeauty.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 11:27:11PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Reimplement execvp for our purposes - after we call fork() it is 
> fundamentally unsafe to use the kernel allocator - current is not valid 
> there.

This is horriby ugly.  Can we instead do something different like
check out the paths of helpers at early boot, before the kernel is
running, save them, and simply execve them later?

At that point, something like running "which foo" would be fine by me.

				Jeff
