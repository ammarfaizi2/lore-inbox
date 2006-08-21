Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWHUCIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWHUCIo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 22:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWHUCIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 22:08:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5906 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750715AbWHUCIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 22:08:44 -0400
Date: Mon, 21 Aug 2006 04:08:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm2: m68k nsproxy compile breakage
Message-ID: <20060821020843.GG11651@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

namespaces-utsname-implement-utsname-namespaces.patch causes the 
following compile error on m68k:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/m68k/kernel/built-in.o: In function `sys_call_table':
(.data+0x91c): undefined reference to `init_nsproxy'

<--  snip  -->

Is there a reason why struct init_nsproxy can't reside in 
kernel/nsproxy.c?

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

