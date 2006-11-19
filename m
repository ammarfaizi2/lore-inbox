Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933078AbWKSTiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078AbWKSTiu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933080AbWKSTiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:38:50 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:60645 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S933078AbWKSTit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:38:49 -0500
Date: Sun, 19 Nov 2006 14:35:28 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml fails to compile due to missing offsetof
Message-ID: <20061119193528.GA4559@ccure.user-mode-linux.org>
References: <20061119120000.GA4926@aepfle.de> <20061119142507.GA3284@ccure.user-mode-linux.org> <20061119155847.GA6890@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119155847.GA6890@aepfle.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 04:58:47PM +0100, Olaf Hering wrote:
> How do you get _STDDEF_H defined in
> /usr/lib/gcc/<target>/<vers>/include/stddef.h ?
> For me _STDDEF_H remains undefined, and /usr/include/linux/stddef.h has
> offsetof inside __KERNEL__.

I guess that the __KERNEL__ is your problem.  I don't see that
anything like that has any business being in the libc headers.  In the
other case of this that I looked at, the stuff in /usr/include/linux/
had been replaced by (or /usr/include/linux symlinked to) a kernel
include/linux.

				Jeff
-- 
Work email - jdike at linux dot intel dot com
