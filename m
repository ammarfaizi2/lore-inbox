Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWJIMlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWJIMlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWJIMlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:41:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751865AbWJIMle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:41:34 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Please pull linux-2.6-irq.git 'master' branch
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 09 Oct 2006 13:41:19 +0100
Message-ID: <10553.1160397679@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch here can also be found at:

	http://people.redhat.com/~dhowells/irq-fixup-typedefs.diff

It converts usages of the function pointer "irqreturn_t (*)(int, void *)" to
instead use the irq_handler_t typedef previously added.

David
---
The following changes since commit 58ba81dba77eab43633ea47d82e96245ae3ff666:
  Al Viro:
        m68k/kernel/dma.c assumes !MMU_SUN3

are found in the git repository at:

  git://git.infradead.org/~dhowells/irq-2.6.git

David Howells:
      IRQ: Use the new typedef for interrupt handler function pointers

 arch/arm/mach-pxa/corgi.c                 |    2 +-
 arch/arm/mach-pxa/idp.c                   |    2 +-
 arch/arm/mach-pxa/lubbock.c               |    4 ++--
 arch/arm/mach-pxa/mainstone.c             |    2 +-
 arch/arm/mach-pxa/poodle.c                |    2 +-
 arch/arm/mach-pxa/spitz.c                 |    2 +-
 arch/arm/mach-pxa/tosa.c                  |    2 +-
 arch/arm/mach-pxa/trizeps4.c              |    2 +-
 arch/ia64/hp/sim/simserial.c              |    2 +-
 arch/m68k/amiga/config.c                  |    4 ++--
 arch/m68k/apollo/config.c                 |    6 +++---
 arch/m68k/atari/config.c                  |    2 +-
 arch/m68k/atari/stdma.c                   |    4 ++--
 arch/m68k/atari/time.c                    |    2 +-
 arch/m68k/bvme6000/config.c               |    6 +++---
 arch/m68k/hp300/time.c                    |    4 ++--
 arch/m68k/hp300/time.h                    |    2 +-
 arch/m68k/kernel/ints.c                   |    2 +-
 arch/m68k/kernel/setup.c                  |    2 +-
 arch/m68k/mac/config.c                    |    4 ++--
 arch/m68k/mac/via.c                       |    2 +-
 arch/m68k/mvme147/config.c                |    6 +++---
 arch/m68k/mvme16x/config.c                |    6 +++---
 arch/m68k/q40/config.c                    |    2 +-
 arch/m68k/q40/q40ints.c                   |    4 ++--
 arch/m68k/sun3/config.c                   |    4 ++--
 arch/m68k/sun3x/time.c                    |    2 +-
 arch/m68k/sun3x/time.h                    |    2 +-
 arch/mips/au1000/common/dma.c             |    2 +-
 arch/mips/au1000/common/irq.c             |    2 +-
 arch/mips/au1000/common/time.c            |    2 +-
 arch/powerpc/kernel/ibmebus.c             |    2 +-
 arch/sparc/kernel/irq.c                   |   10 +++++-----
 arch/sparc/kernel/sun4c_irq.c             |    2 +-
 arch/sparc/kernel/sun4d_irq.c             |    4 ++--
 arch/sparc/kernel/sun4m_irq.c             |    2 +-
 arch/sparc/kernel/tick14.c                |    2 +-
 arch/um/include/irq_kern.h                |    4 ++--
 arch/um/kernel/irq.c                      |    4 ++--
 include/asm-arm/arch-pxa/mmc.h            |    2 +-
 include/asm-m68k/atari_stdma.h            |    2 +-
 include/asm-m68k/ide.h                    |    2 +-
 include/asm-m68k/machdep.h                |    2 +-
 include/asm-mips/mach-au1x00/au1000_dma.h |    2 +-
 include/asm-powerpc/ibmebus.h             |    2 +-
 include/asm-sparc/irq.h                   |    6 +++---
 46 files changed, 70 insertions(+), 70 deletions(-)
