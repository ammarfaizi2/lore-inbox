Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTJ1XJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTJ1XJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:09:27 -0500
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:1810 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S261801AbTJ1XJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:09:12 -0500
Date: Tue, 28 Oct 2003 15:09:10 -0800
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-scsi@vger.kernel.org
Subject: ide-scsi "lost interrupt" (2.6.0-test9)
Message-ID: <20031028230910.GM32594@ruvolo.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

When attempting to use cdrecord under 2.6.0-test9 with a ide-scsi ATAPI
device, the burn fails and I get the following kernel output.  This has
happened both times I tried to burn a CD, at both 4x and 2x write.  This is
with DMA disabled via "/sbin/hdparm -d 0 /dev/hdc".

Any advise here?  (cdrecord with -dev=ATAPI doesn't seem to work)

BTW, there doesn't seem to be a maintainer for the ide-scsi module.  Is that
correct?

Also, there's another ide-scsi problem I just noticed.  When unloading the
ide-scsi module and reloading it, it gets assigned a new bus.  On the
initial load my CD device as -dev=0,0,0.  Now it is -dev=2,0,0.  The code to
unregister the bus seems to have been removed between -test1 and -test9.
Can anyone say why?

Thanks,

-Chris


hdc: lost interrupt
Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c01166a2>] __wake_up_locked+0x22/0x30
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c01166a2>] __wake_up_locked+0x22/0x30
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c01166a2>] __wake_up_locked+0x22/0x30
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c01166a2>] __wake_up_locked+0x22/0x30
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c01166a2>] __wake_up_locked+0x22/0x30
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c01166a2>] __wake_up_locked+0x22/0x30
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01c4dc1>] vt_console_print+0x61/0x2f0
 [<c01166a2>] __wake_up_locked+0x22/0x30
 [<c0108305>] __down+0x85/0x100
 [<c0116580>] default_wake_function+0x0/0x30
 [<c010852f>] __down_failed+0xb/0x14
 [<c897a2df>] .text.lock.scsi_error+0x37/0x48 [scsi_mod]
 [<c8979ac0>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c8935918>] idescsi_abort+0xf8/0x110 [ide_scsi]
 [<c897940d>] scsi_try_to_abort_cmd+0x5d/0x80 [scsi_mod]
 [<c897954a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8979f82>] scsi_unjam_host+0xa2/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

Call Trace:
 [<c0116525>] schedule+0x595/0x5a0
 [<c01165ea>] __wake_up_common+0x3a/0x70
 [<c0121dae>] schedule_timeout+0x5e/0xb0
 [<c0121d40>] process_timeout+0x0/0x10
 [<c8935a33>] idescsi_reset+0x103/0x120 [ide_scsi]
 [<c89795d6>] scsi_try_bus_device_reset+0x56/0x90 [scsi_mod]
 [<c8979687>] scsi_eh_bus_device_reset+0x77/0x130 [scsi_mod]
 [<c8979e08>] scsi_eh_ready_devs+0x28/0x80 [scsi_mod]
 [<c8979f9f>] scsi_unjam_host+0xbf/0xd0 [scsi_mod]
 [<c897a080>] scsi_error_handler+0xd0/0x110 [scsi_mod]
 [<c8979fb0>] scsi_error_handler+0x0/0x110 [scsi_mod]
 [<c0107479>] kernel_thread_helper+0x5/0xc

hdc: ATAPI reset complete

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/nvcWKO6EG1hc77ERAnQ2AKDgdn0BCD88qqwxqHp9/BMGfmkn5wCgu0ia
fni91qsK4T785MEznzaUjEM=
=JnLq
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
