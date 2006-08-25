Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWHYSyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWHYSyH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWHYSyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:54:07 -0400
Received: from white.metrobridge.net ([65.39.152.239]:63129 "EHLO
	white.metrobridge.net") by vger.kernel.org with ESMTP
	id S964923AbWHYSyE (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:54:04 -0400
Message-ID: <BF31A0C9BB75D2119B9C00105A11D260B4901E@SEVILLE>
From: Ming Li <Ming@cojentsystems.com>
To: "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: reboot problem
Date: Fri, 25 Aug 2006 11:55:25 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Sam, I found your email address at MAINTAINERS of SuSE 10.1.

I met a problem when I reboot the Radiant machine, it just halt when
rebooting after shutdown all the resources.

I did some research, the reason is the SuSE linux 10.1 Set the low to the
reset of keyboard controller, but unfortunately, there is not keyboard
controller in Radiant machine, so bios can not start the POST code.

Firstly, I added the parameter "reboot=bios" in /boot/grub/menu.lst, try to
let reboot using bios post, it does work, I do not know why ?

Secondly, I built a new kernel added some debug information in file
/usr/src/linux/arch/i386/kernel/reboot.c,  I added debug information in
functions "machine_restart()" , "machine_real_restart()", "reboot_setup()" ,
but when I running command "reboot", I did not see my debug information,
what I was try to do is to call the function: "machine_real_restart()", but
it seems to me that, functions of reboot.c do not be call during the
rebooting. 

Thirdly, I check the command "reboot" in /sbin, it just the symbol link to
the command "halt", I am little bit confused.

My question is :

1. where is the reboot source code, what files are actually do the rebooting
work ?
2. Why command "reboot" command is just a symbol link to the command "halt"
?
3. What can I do to reboot machine by bios mode ?

Thank you very much, I appreciate your time.

Regards,
Sam.

