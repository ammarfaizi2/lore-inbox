Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUHDJuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUHDJuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUHDJuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:50:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:30368 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262418AbUHDJuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:50:04 -0400
Date: Wed, 4 Aug 2004 11:50:03 +0200 (MEST)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <24770.1091613003@www56.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a "make bzImage" produces this command:

cmd_arch/i386/kernel/vmlinux.lds.s :=                                       
   
gcc -E -Wp,-MD,arch/i386/kernel/.vmlinux.lds.s.d                            
   
 -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -D__ASSEMBLY__      
   
 -Iinclude/asm-i386/mach-default -traditional                               
   
                                                                            
   
    -o arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/vmlinux.lds.S        
   
                                                                            
   
it should produce something like this:

cmd_arch/i386/kernel/vmlinux.lds.s :=                                       
   
gcc -E -Wp,-MD,arch/i386/kernel/.vmlinux.lds.s.d                            
   
 -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -D__ASSEMBLY__      
   
 -Iinclude/asm-i386/mach-default -traditional                               
   
 -P -C -Ui386                                                               
   
    -o arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/vmlinux.lds.S

see the last but one line for the difference.

-Alex. (i am not subscribed to this list)

-- 
NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl

