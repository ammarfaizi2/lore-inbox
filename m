Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVLYSeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVLYSeR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 13:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVLYSeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 13:34:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:8835 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750886AbVLYSeQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 13:34:16 -0500
Date: Sun, 25 Dec 2005 18:34:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Kees Cook <kees@outflux.net>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: zlib_inflate "r.base" uninitialized compile warnings
Message-ID: <20051225183406.GB27946@ftp.linux.org.uk>
References: <20051225180758.GM18040@outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225180758.GM18040@outflux.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 10:07:58AM -0800, Kees Cook wrote:
> Eliminates compile-time warnings from "r" being uninitialized.

NAK.  That sort of patches is only going to hide real problems in the
code where such warnings are _not_ false positives.

Let me put it that way: what bug are you fixing in that patch?  Is
there a codepath that would lead to use of r without initialization?
If there is - show it; if there is not - why are you patching kernel
and not gcc?
