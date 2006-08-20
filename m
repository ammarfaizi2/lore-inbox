Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWHTXyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWHTXyj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWHTXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:54:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932103AbWHTXyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:54:38 -0400
Date: Mon, 21 Aug 2006 01:54:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: Alpha: replacing "extern inline"
Message-ID: <20060820235438.GY7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to get rid of all "extern inline" in the kernel.

Why?
"extern inline" generates a warning with -Wmissing-prototypes and I'm 
currently working on getting the kernel cleaned up for adding this to 
the CFLAGS since it will help us to avoid a nasty class of runtime 
errors.

"extern inline" was required at the times when 
__attribute__((always_inline)) wasn't avalable.

Nowadays, we use "static inline", and if there are places that really 
need a forced inline, we use "static __always_inline".

Can someone tell me which of the Alpha "static inline"'s need for some 
reason an __always_inline?

And a related question:
Does the never defined __IO_EXTERN_INLINE still have any purpose?

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

