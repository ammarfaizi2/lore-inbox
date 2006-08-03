Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWHCTj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWHCTj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHCTj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:39:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14864 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932320AbWHCTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:39:56 -0400
Date: Thu, 3 Aug 2006 21:39:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Userspace visible of 3 include/asm/ headers
Message-ID: <20060803193952.GF25692@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could anyone help me regarding the desired userspace visibility of the 
following three headers under include/asm/?


Header        : cpufeature.h
Architectures : i386, x86_64
Is there any reason why this header is exported to userspace?

Header        : setup.h
Architectures : i386, ia64, x86_64
Contents:
- COMMAND_LINE_SIZE on ia64, x86_64
- much more on i386
Should COMMAND_LINE_SIZE be visible to userspace?
Anything else from the i386 setup.h?

Header        : timex.h
Architectures : all architectures
Offers CLOCK_TICK_RATE on all architectures, but on some architectures
(like i386) this depends on the kernel configuration.
-> not a userspace header?


TIA
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

