Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWJGOoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWJGOoz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 10:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWJGOoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 10:44:55 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:41376 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932116AbWJGOoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 10:44:54 -0400
Date: Sat, 7 Oct 2006 08:44:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061007144453.GY2563@parisc-linux.org>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org> <20061006164211.GA15321@flint.arm.linux.org.uk> <Pine.LNX.4.64.0610061055490.3952@g5.osdl.org> <20061007025444.GV2563@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007025444.GV2563@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 08:54:44PM -0600, Matthew Wilcox wrote:
> git-pull git://git.parisc-linux.org/git/linux-2.6.git irq-fixes
> 
> Or apply the patch below, if that's easier

And the next series of patches actually make it boot.

git-pull git://git.parisc-linux.org/git/linux-2.6.git irq-fixes

Kyle McMartin:
      [PARISC] Make firmware calls irqsafe-ish...

Matthew Wilcox:
      [PARISC] Use set_irq_regs
      [PA-RISC] Fix boot breakage
      [PARISC] pdc_init no longer exists
      [PARISC] More pt_regs removal

 arch/parisc/kernel/drivers.c  |    6 -
 arch/parisc/kernel/firmware.c |  250 +++++++++++++++++++++++++-----------------
 arch/parisc/kernel/irq.c      |    3 
 arch/parisc/kernel/smp.c      |   15 --
 arch/parisc/kernel/time.c     |   32 ++---
 include/asm-parisc/pdc.h      |    2 
 6 files changed, 177 insertions(+), 131 deletions(-)

