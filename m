Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUFAQJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUFAQJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUFAQIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:08:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42716 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265100AbUFAQHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:07:22 -0400
Date: Tue, 1 Jun 2004 18:07:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.7-rc2: .bss.page_aligned warning with gcc 2.95
Message-ID: <20040601160714.GD25681@fs.tum.de>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 11:52:50PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.7-rc1 to v2.6.7-rc2
> ============================================
>...
> Matt Mackall:
>   o i386: put irq stacks in .bss.page_aligned section
>...

This patch causess the following compile warning when using gcc 2.95
(observed in 2.6.7-rc2-mm1):

<--  snip  -->

...
  CC      arch/i386/kernel/irq.o
{standard input}: Assembler messages:
{standard input}:3612: Warning: setting incorrect section type for .bss.page_aligned
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

