Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTJGHQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 03:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJGHQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 03:16:25 -0400
Received: from [212.123.215.12] ([212.123.215.12]:2576 "EHLO dmx.imc.nl")
	by vger.kernel.org with ESMTP id S261850AbTJGHQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 03:16:23 -0400
Message-ID: <3F82682E.1030409@imc.nl>
Date: Tue, 07 Oct 2003 09:15:58 +0200
From: Roelf Schreurs <rosc@imc.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mptbase module problem on 2.6
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm having trouble with the mptbase module.
This is what I do and the error I get.

xconfig - Fusion MPT device support - all is selected as modules
make bzImage
make modules
...
 CC [M]  drivers/message/fusion/mptbase.o
 CC [M]  drivers/message/fusion/mptscsih.o
 CC [M]  drivers/message/fusion/mptctl.o
 CC      drivers/message/fusion/mptbase.mod.o
 LD [M]  drivers/message/fusion/mptbase.ko
 CC      drivers/message/fusion/mptctl.mod.o
 LD [M]  drivers/message/fusion/mptctl.ko
 CC      drivers/message/fusion/mptscsih.mod.o
 LD [M]  drivers/message/fusion/mptscsih.ko
...
make modules_install
...
depmod:         mpt_register_ascqops_strings
depmod:         mpt_deregister_ascqops_strings
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test6/kernel/drivers/message/fusion/mptctl.ko

depmod:         mpt_free_fw_memory
depmod:         mpt_reset_deregister
depmod:         mpt_free_msg_frame
depmod:         mpt_register
depmod:         mpt_HardResetHandler
depmod:         mpt_put_msg_frame
depmod:         mpt_add_sge
depmod:         mpt_GetIocState
depmod:         mpt_alloc_fw_memory
depmod:         mpt_reset_register
depmod:         mpt_verify_adapter
depmod:         mpt_send_handshake_request
depmod:         mpt_deregister
depmod:         mpt_get_msg_frame
depmod:         mpt_config
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test6/kernel/drivers/message/fusion/mptscsih.ko

depmod:         mpt_adapter_find_first
depmod:         mpt_print_ioc_summary
depmod:         mpt_reset_deregister
depmod:         mpt_event_deregister
depmod:         mpt_free_msg_frame
depmod:         mpt_register
depmod:         mpt_HardResetHandler
depmod:         mpt_put_msg_frame
depmod:         mpt_v_ASCQ_TablePtr
depmod:         mpt_add_sge
depmod:         mpt_read_ioc_pg_3
depmod:         mpt_ASCQ_TableSz
depmod:         mpt_GetIocState
depmod:         mpt_adapter_find_next
depmod:         mpt_reset_register
depmod:         mpt_event_register
depmod:         mpt_ScsiOpcodesPtr
depmod:         mpt_send_handshake_request
depmod:         mpt_deregister
depmod:         mpt_get_msg_frame
depmod:         mpt_config

INSTALL drivers/message/fusion/mptbase.ko
...

mkinitrd /boot/initrd-2.6.0-test6 2.6.0-test6
([root@magelhaen kernel2.6]# ls -l /lib/modules/
total 4
drwxr-xr-x    4 root     root         1024 Oct  3 19:49 2.4.18-3
drwxr-xr-x    4 root     root         1024 Oct  6 12:44 2.4.18-3debug
drwxr-xr-x    4 root     root         1024 Oct  3 19:49 2.4.18-3smp
drwxr-xr-x    3 root     root         1024 Oct  7 09:01 2.6.0-test6
)

No module mptbase found for kernel 2.6.0-test6 - This is the problem.

using linux-2.6.0-test6.tar on Red Hat Linux release 7.3 (Valhalla)

-- 
Roelf Schreurs

