Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbULFRka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbULFRka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbULFRg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:36:58 -0500
Received: from pop.gmx.de ([213.165.64.20]:61641 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261559AbULFRgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:36:00 -0500
X-Authenticated: #1425685
Date: Mon, 6 Dec 2004 18:34:32 +0100
From: Ostdeutschland <Ostdeutschland@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Compiletime warning in 2.6.10-rc3
Message-Id: <20041206183432.4efc55ea.Ostdeutschland@gmx.de>
X-Mailer: Sylpheed version 1.0.0beta2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while compiling 2.6.10-rc3 i noticed the following warnings:


  CC      kernel/intermodule.o
kernel/intermodule.c:179: warning: `inter_module_register' is deprecated (declared at kernel/intermodule.c:38)

kernel/intermodule.c:180: warning: `inter_module_unregister' is deprecated (declared at kernel/intermodule.c:79)

kernel/intermodule.c:183: warning: `inter_module_put' is deprecated (declared at kernel/intermodule.c:160)


  CC      fs/binfmt_elf.o
fs/binfmt_elf.c: In function `padzero':
fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result

include/asm/uaccess.h: In function `create_elf_tables':
fs/binfmt_elf.c:175: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result

fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:776: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result

fs/binfmt_elf.c: In function `fill_psinfo':
fs/binfmt_elf.c:1238: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result


  CC      drivers/char/agp/backend.o
drivers/char/agp/backend.c: In function `agp_add_bridge':
drivers/char/agp/backend.c:281: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:577)

drivers/char/agp/backend.c: In function `agp_remove_bridge':
drivers/char/agp/backend.c:301: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:578)


  CC      net/ipv6/ip6_flowlabel.o
net/ipv6/ip6_flowlabel.c: In function `ipv6_flowlabel_opt':
net/ipv6/ip6_flowlabel.c:541: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result



gcc-Version 3.4.1


Thanks, Sebastian
