Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262031AbSJEEsB>; Sat, 5 Oct 2002 00:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262035AbSJEEsB>; Sat, 5 Oct 2002 00:48:01 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:7394 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262031AbSJEEsA>; Sat, 5 Oct 2002 00:48:00 -0400
Date: Thu, 3 Oct 2002 23:32:40 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40-ac2 link error
Message-ID: <20021004033240.GA30890@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What am I missing here?

ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
		arch/i386/kernel/head.o arch/i386/kernel/init_task.o  
		init/built-in.o --start-group  arch/i386/kernel/built-in.o  
		arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o 
		kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o 
		security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  
		drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  
		net/built-in.o --end-group  -o .tmp_vmlinux
drivers/built-in.o: In function `handle_remote_request':
drivers/built-in.o(.text+0x48714): undefined reference to `queue_task'
drivers/built-in.o: In function `handle_iso_send':
drivers/built-in.o(.text+0x48a6f): undefined reference to `queue_task'
make[1]: *** [.tmp_vmlinux] Error 1


-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

