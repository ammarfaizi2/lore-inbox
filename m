Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUETLRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUETLRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 07:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUETLRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 07:17:44 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:2251 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262459AbUETLRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 07:17:43 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.6] badness when removing ipmi_si module
Date: Thu, 20 May 2004 13:18:12 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405201318.17054.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello List,

This popped up when calling rmmod ipmi_si:

Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c017e24a>] remove_proc_entry+0xfa/0x130
 [<c8971649>] ipmi_unregister_smi+0x79/0x150 [ipmi_msghandler]
 [<c8934a74>] cleanup_one_si+0xa4/0x100 [ipmi_si]
 [<c0132a66>] stop_machine_run+0x16/0x1a
 [<c8934aed>] cleanup_ipmi_si+0x1d/0x31 [ipmi_si]
 [<c012fbb2>] sys_delete_module+0x132/0x170
 [<c014410a>] unmap_vma_list+0x1a/0x30
 [<c01445a7>] do_munmap+0x137/0x180
 [<c0103edb>] syscall_call+0x7/0xb

On a related note, does anyone know any implementations of ipmi-management 
tools that work on an ipmi 1.0 machine? The ipmi-tools only work on 1.5...

Thanks.

Jan

- -- 
"Do not meddle in the affairs of wizards, for you are crunchy and good
with ketchup."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArJP3UQQOfidJUwQRAgnNAJ99sMZiJHZxUAbFB4jUKrhAP3ULCQCfaKq5
h+bpmBd3YVLGGg3QaOgP/xE=
=jckg
-----END PGP SIGNATURE-----
