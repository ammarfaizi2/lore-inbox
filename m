Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUHXU5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUHXU5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUHXU5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:57:05 -0400
Received: from holomorphy.com ([207.189.100.168]:12678 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268323AbUHXU4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:56:24 -0400
Date: Tue, 24 Aug 2004 13:56:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040824205621.GU2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822013402.5917b991.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 01:34:02AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm4/
> - Added the kexec code.  Again.  This was in -mm a year or so ago but didn't
>   make it.
> - This kernel has an x86 patch which alters the copy_*_user() functions so
>   they will return -EFAULT on a fault rather than the number of bytes which
>   remain to be copied.  This is a bit of an experiment, because this seems to
>   be the preferred API for those functions.   It's a see-what-breaks thing.
>   And things will break.  If weird behaviour is observed, please revert
>   usercopy-return-EFAULT.patch and send a report.

__builtin_return_address() with non-constant arguments is unsupported on
various architectures.


fs/reiser4/context.c: In function `get_context_ok':
fs/reiser4/context.c:88: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:89: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:90: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:91: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:92: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:93: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:94: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:95: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:96: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:97: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:98: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:99: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:100: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:101: warning: unsupported arg to `__builtin_return_address'
fs/reiser4/context.c:102: warning: unsupported arg to `__builtin_return_address'
