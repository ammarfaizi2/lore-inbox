Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbTJGUAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJGUAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:00:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:12947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262651AbTJGUAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:00:44 -0400
Date: Tue, 7 Oct 2003 12:52:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Roelf Schreurs <rosc@imc.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mptbase module problem on 2.6
Message-Id: <20031007125204.661ba758.rddunlap@osdl.org>
In-Reply-To: <3F82682E.1030409@imc.nl>
References: <3F82682E.1030409@imc.nl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Oct 2003 09:15:58 +0200 Roelf Schreurs <rosc@imc.nl> wrote:

| Hi
| 
| I'm having trouble with the mptbase module.
| This is what I do and the error I get.
| 
| xconfig - Fusion MPT device support - all is selected as modules
| make bzImage
| make modules
| ...
|  CC [M]  drivers/message/fusion/mptbase.o
|  CC [M]  drivers/message/fusion/mptscsih.o
|  CC [M]  drivers/message/fusion/mptctl.o
|  CC      drivers/message/fusion/mptbase.mod.o
|  LD [M]  drivers/message/fusion/mptbase.ko
|  CC      drivers/message/fusion/mptctl.mod.o
|  LD [M]  drivers/message/fusion/mptctl.ko
|  CC      drivers/message/fusion/mptscsih.mod.o
|  LD [M]  drivers/message/fusion/mptscsih.ko
| ...
| make modules_install
| ...
| depmod:         mpt_register_ascqops_strings
| depmod:         mpt_deregister_ascqops_strings
| depmod: *** Unresolved symbols in
| /lib/modules/2.6.0-test6/kernel/drivers/message/fusion/mptctl.ko
| 
| depmod:         mpt_free_fw_memory
| depmod:         mpt_reset_deregister
| depmod:         mpt_free_msg_frame
| depmod:         mpt_register
| depmod:         mpt_HardResetHandler
| depmod:         mpt_put_msg_frame
| depmod:         mpt_add_sge
| depmod:         mpt_GetIocState
| depmod:         mpt_alloc_fw_memory
| depmod:         mpt_reset_register
| depmod:         mpt_verify_adapter
| depmod:         mpt_send_handshake_request
| depmod:         mpt_deregister
| depmod:         mpt_get_msg_frame
| depmod:         mpt_config
| depmod: *** Unresolved symbols in
| /lib/modules/2.6.0-test6/kernel/drivers/message/fusion/mptscsih.ko
| 
| depmod:         mpt_adapter_find_first
| depmod:         mpt_print_ioc_summary
| depmod:         mpt_reset_deregister
| depmod:         mpt_event_deregister
| depmod:         mpt_free_msg_frame
| depmod:         mpt_register
| depmod:         mpt_HardResetHandler
| depmod:         mpt_put_msg_frame
| depmod:         mpt_v_ASCQ_TablePtr
| depmod:         mpt_add_sge
| depmod:         mpt_read_ioc_pg_3
| depmod:         mpt_ASCQ_TableSz
| depmod:         mpt_GetIocState
| depmod:         mpt_adapter_find_next
| depmod:         mpt_reset_register
| depmod:         mpt_event_register
| depmod:         mpt_ScsiOpcodesPtr
| depmod:         mpt_send_handshake_request
| depmod:         mpt_deregister
| depmod:         mpt_get_msg_frame
| depmod:         mpt_config
| 
| INSTALL drivers/message/fusion/mptbase.ko
| ...
| 
| mkinitrd /boot/initrd-2.6.0-test6 2.6.0-test6
| ([root@magelhaen kernel2.6]# ls -l /lib/modules/
| total 4
| drwxr-xr-x    4 root     root         1024 Oct  3 19:49 2.4.18-3
| drwxr-xr-x    4 root     root         1024 Oct  6 12:44 2.4.18-3debug
| drwxr-xr-x    4 root     root         1024 Oct  3 19:49 2.4.18-3smp
| drwxr-xr-x    3 root     root         1024 Oct  7 09:01 2.6.0-test6
| )
| 
| No module mptbase found for kernel 2.6.0-test6 - This is the problem.
| 
| using linux-2.6.0-test6.tar on Red Hat Linux release 7.3 (Valhalla)

Hi,

I don't see this problem in 2.6.0-test6.

Are you using the latest/current module-init-tools (and not modutils
from Linux 2.4)?

What does 'depmod -V' report?

module-init-tools are found at
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

--
~Randy
