Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbTHJRAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 13:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTHJRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 13:00:51 -0400
Received: from elvas.procergs.com.br ([200.198.128.213]:54283 "EHLO
	elvas.procergs.com.br") by vger.kernel.org with ESMTP
	id S270142AbTHJRAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 13:00:48 -0400
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.0-test[123]: nvidia driver broke the ALSA sound for
 NForce
From: Otavio Salvador <otavio@debian.org>
Date: Sun, 10 Aug 2003 14:00:46 -0300
Message-ID: <87wudlih1d.fsf@retteb.casa>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Folks,

I've tried the tree kernels and all doesn't play well the sound using
ALSA for Nforce (intel8x0). This problem anly ocours when nvidia
driver is loaded. 

Bellow are some calltrace from syslog about this:

Aug  4 13:56:56 retteb kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug  4 13:56:56 retteb kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Aug  4 13:56:56 retteb kernel: agpgart: Putting AGP V2 device at 0000:02:00.0 into 4x mode
Aug  4 13:56:56 retteb kernel: Badness in pci_find_subsys at drivers/pci/search.c:132
Aug  4 13:56:56 retteb kernel: Call Trace:
Aug  4 13:56:56 retteb kernel:  [pci_find_subsys+232/240] pci_find_subsys+0xe8/0xf0
Aug  4 13:56:56 retteb kernel:  [pci_find_device+47/64] pci_find_device+0x2f/0x40
Aug  4 13:56:56 retteb kernel:  [pci_find_slot+40/80] pci_find_slot+0x28/0x50
Aug  4 13:56:56 retteb kernel:  [_end+528808817/1069608232] os_pci_init_handle+0x39/0x70 [nvidia]
Aug  4 13:56:56 retteb kernel:  [_end+527652855/1069608232] __nvsym00015+0x1f/0x24 [nvidia]
Aug  4 13:56:56 retteb kernel:  [_end+528468051/1069608232] __nvsym03985+0x1f/0x24 [nvidia]
Aug  4 13:56:56 retteb kernel:  [_end+528324424/1069608232] __nvsym03792+0x208/0x1c38 [nvidia]
Aug  4 13:56:56 retteb kernel:  [check_journal_end+376/656] check_journal_end+0x178/0x290
Aug  4 13:56:56 retteb kernel:  [do_journal_end+211/3168] do_journal_end+0xd3/0xc60
Aug  4 13:56:56 retteb kernel:  [__block_commit_write+142/144] __block_commit_write+0x8e/0x90
Aug  4 13:56:56 retteb kernel:  [generic_commit_write+74/176] generic_commit_write+0x4a/0xb0
Aug  4 13:56:56 retteb kernel:  [reiserfs_commit_write+264/400] reiserfs_commit_write+0x108/0x190
Aug  4 13:56:56 retteb kernel:  [block_prepare_write+52/80] block_prepare_write+0x34/0x50
Aug  4 13:56:56 retteb kernel:  [unlock_page+21/96] unlock_page+0x15/0x60
Aug  4 13:56:56 retteb kernel:  [generic_file_aio_write_nolock+1292/2960] generic_file_aio_write_nolock+0x50c/0xb90
Aug  4 13:56:56 retteb kernel:  [_end+528267728/1069608232] __nvsym03662+0x78/0x84 [nvidia]
Aug  4 13:56:56 retteb kernel:  [_end+528220881/1069608232] __nvsym03555+0x105/0x11c [nvidia]
Aug  4 13:56:56 retteb kernel:  [_end+527669600/1069608232] __nvsym00758+0x78/0xb0 [nvidia]

The driver of nvidia is 4496 and if I remove this all sound is back to
normal. 

Anyone have some idea where is the problem or how fix this?

TIA,
Otavio
                                   
-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
